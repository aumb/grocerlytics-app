import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocerlytics/features/app/app_cubit.dart';
import 'package:grocerlytics/features/auth/ui/auth_cubit.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/features/common/currencies/ui/currencies_cubit.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/quantity_units/ui/quantity_units_cubit.dart';
import 'package:grocerlytics/features/common/services/refresh_token/refresh_token_cubit.dart';
import 'package:grocerlytics/features/common/theme/ui/theme_cubit.dart';
import 'package:grocerlytics/features/common/ui/error_page.dart';
import 'package:grocerlytics/features/common/ui/toasts.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';
import 'package:grocerlytics/features/sync/ui/sync_cubit.dart';
import 'package:grocerlytics/router/observers/cubit_observer.dart';
import 'package:grocerlytics/router/router.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:plausible_analytics/navigator_observer.dart';
import 'package:plausible_analytics/plausible_analytics.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  Bloc.observer = const CubitObserver();

  runApp(
    MainApp(
      currenciesCubit: getIt.get<CurrenciesCubit>(),
      quantityUnitsCubit: getIt.get<QuantityUnitsCubit>(),
      categoriesCubit: getIt.get<CategoriesCubit>(),
      authCubit: getIt.get<AuthCubit>(),
      syncCubit: getIt.get<SyncCubit>(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({
    super.key,
    required this.currenciesCubit,
    required this.quantityUnitsCubit,
    required this.categoriesCubit,
    required this.authCubit,
    required this.syncCubit,
  });

  final CurrenciesCubit currenciesCubit;
  final QuantityUnitsCubit quantityUnitsCubit;
  final CategoriesCubit categoriesCubit;
  final AuthCubit authCubit;
  final SyncCubit syncCubit;

  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return ShadApp.router(
            themeMode: state,
            darkTheme: ShadThemeData(
              brightness: Brightness.dark,
              colorScheme:
                  const ShadGrayColorScheme.dark(border: Color(0xff1c2532)),
              textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.inter),
            ),
            theme: ShadThemeData(
              brightness: Brightness.light,
              colorScheme: const ShadGrayColorScheme.light(),
              textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.inter),
            ),
            builder: (context, child) => MultiBlocProvider(
              providers: [
                BlocProvider<RefreshTokenCubit>(
                  create: (_) => getIt.get<RefreshTokenCubit>(),
                ),
                BlocProvider<SyncCubit>(
                  create: (_) => syncCubit,
                ),
                BlocProvider<AuthCubit>(
                  create: (_) => authCubit,
                ),
                BlocProvider<CurrenciesCubit>(
                  create: (_) => currenciesCubit,
                ),
                BlocProvider<QuantityUnitsCubit>(
                  create: (_) => quantityUnitsCubit,
                ),
                BlocProvider<CategoriesCubit>(
                  create: (_) => categoriesCubit,
                ),
                BlocProvider<AppCubit>(
                  create: (_) => getIt.get<AppCubit>()
                    ..init(
                      currenciesCubit.init,
                      quantityUnitsCubit.init,
                      categoriesCubit.init,
                      authCubit.fetchUser,
                      syncCubit.syncWithServer,
                    ),
                ),
              ],
              child: BlocListener<RefreshTokenCubit, RefreshTokenState>(
                listener: (context, state) {
                  switch (state.status) {
                    case InitialStatus<RefreshTokenState>():
                    case LoadingStatus<RefreshTokenState>():
                    case LoadedStatus<RefreshTokenState>():
                    case EmptyStatus<RefreshTokenState>():
                      break;
                    case ErrorStatus<RefreshTokenState>():
                      router.pushAndPopUntil(
                        const HomeRoute(),
                        predicate: (_) => false,
                      );
                      context.read<AuthCubit>().resetAuth();
                      context.read<AppCubit>().init(
                            currenciesCubit.init,
                            quantityUnitsCubit.init,
                            categoriesCubit.init,
                            authCubit.fetchUser,
                            syncCubit.syncWithServer,
                          );
                      ShadToaster.of(context).show(
                        errorToast(
                          body:
                              'We could not log you in please log in again manually',
                        ),
                      );
                  }
                },
                child: BlocListener<SyncCubit, SyncState>(
                  listener: (context, state) {
                    switch (state.status) {
                      case InitialStatus<SyncState>():
                      case LoadingStatus<SyncState>():
                      case LoadedStatus<SyncState>():
                      case EmptyStatus<SyncState>():
                        break;
                      case ErrorStatus<SyncState>():
                        ShadToaster.of(context).show(
                          errorToast(
                            body:
                                'There was a problem syncing your account, we will retry later',
                          ),
                        );
                    }
                  },
                  child: BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) => switch (state.status) {
                            InitialStatus<AppState>() ||
                            LoadingStatus<AppState>() =>
                              const Scaffold(
                                body: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            LoadedStatus<AppState>() =>
                              child ?? const SizedBox.shrink(),
                            ErrorStatus<AppState>() => ErrorPage(
                                refreshCallback: () =>
                                    context.read<AppCubit>().init(
                                          currenciesCubit.init,
                                          quantityUnitsCubit.init,
                                          categoriesCubit.init,
                                          authCubit.fetchUser,
                                          syncCubit.syncWithServer,
                                        ),
                              ),
                            EmptyStatus<AppState>() => const SizedBox.shrink(),
                          }),
                ),
              ),
            ),
            routerConfig: router.config(
              navigatorObservers: () => [
                PlausibleNavigatorObserver(getIt<Plausible>()),
              ],
            ),
          );
        },
      ),
    );
  }
}
