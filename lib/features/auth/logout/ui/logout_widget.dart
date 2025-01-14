import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/app/app_cubit.dart';
import 'package:grocerlytics/features/auth/logout/ui/logout_cubit.dart';
import 'package:grocerlytics/features/auth/ui/auth_cubit.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/features/common/currencies/ui/currencies_cubit.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/quantity_units/ui/quantity_units_cubit.dart';
import 'package:grocerlytics/features/common/ui/dialogs.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';
import 'package:grocerlytics/features/settings/ui/settings_page.dart';
import 'package:grocerlytics/features/sync/ui/sync_cubit.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return BlocProvider<LogoutCubit>(
      create: (_) => getIt.get<LogoutCubit>(),
      child: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (_, state) {
          switch (state.status) {
            case InitialStatus<LogoutState>():
            case LoadingStatus<LogoutState>():
            case ErrorStatus<LogoutState>():
            case EmptyStatus<LogoutState>():
              break;
            case LoadedStatus<LogoutState>():
              context.read<AuthCubit>().resetAuth();
              context.router
                  .pushAndPopUntil(const HomeRoute(), predicate: (_) => false);

              context.read<AppCubit>().init(
                    context.read<CurrenciesCubit>().init,
                    context.read<QuantityUnitsCubit>().init,
                    context.read<CategoriesCubit>().init,
                    context.read<AuthCubit>().fetchUser,
                    context.read<SyncCubit>().syncWithServer,
                  );
          }
        },
        builder: (context, __) => ListTile(
          leading: Icon(
            LucideIcons.logOut,
            color: theme.colorScheme.destructive,
          ),
          onTap: () async {
            final res = await showShadDialog(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(18),
                child: confirmDialog(
                  context: context,
                  title: 'Are you sure you want to logout?',
                  description:
                      'All data is tied to your current account so you would need to log back in to view it, or start from scratch',
                  trackingPage: '$SettingsPage',
                ),
              ),
            );

            if (res && context.mounted) {
              context.read<LogoutCubit>().logout();
            }
          },
          title: Text(
            'Logout',
            style: TextStyle(
              color: theme.colorScheme.destructive,
            ),
          ),
        ),
      ),
    );
  }
}
