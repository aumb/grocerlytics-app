import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/auth/ui/auth_cubit.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/ui/toasts.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';
import 'package:grocerlytics/features/spending/ui/spending_cubit.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const routes = [
      SpendingRoute(),
      EmptyRoute(),
      SettingsRoute(),
    ];
    final theme = ShadTheme.of(context);

    return BlocProvider(
      create: (context) => getIt.get<SpendingCubit>()
        ..init(
          context.read<CategoriesCubit>().state.categories,
          context.read<AuthCubit>().state.user.id,
        ),
      child: BlocListener<SpendingCubit, SpendingState>(
        listener: (context, state) {
          switch (state.status) {
            case InitialStatus<SpendingState>():
            case LoadingStatus<SpendingState>():
            case LoadedStatus<SpendingState>():
            case EmptyStatus<SpendingState>():
              break;
            case ErrorStatus<SpendingState>():
              ShadToaster.of(context).show(
                errorToast(
                  body:
                      'There was a problem getting your spending data, please try again',
                ),
              );
          }
        },
        child: AutoTabsRouter(
          routes: routes,
          transitionBuilder: (context, child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);

            return Scaffold(
              body: child,
              bottomNavigationBar: NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                backgroundColor: theme.colorScheme.secondary,
                selectedIndex: tabsRouter.activeIndex,
                indicatorColor: theme.colorScheme.ring,
                onDestinationSelected: (index) {
                  if (index == 1) {
                    tabsRouter.navigate(AddReceiptNavigationRoute(
                      spendingCubit: context.read<SpendingCubit>(),
                    ));
                  } else {
                    tabsRouter.setActiveIndex(index);
                  }
                },
                destinations: [
                  NavigationDestination(
                    icon: const Icon(Icons.home),
                    selectedIcon:
                        Icon(Icons.home, color: theme.colorScheme.background),
                    label: 'Spending',
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.add_box_outlined),
                    label: 'Add',
                    selectedIcon:
                        Icon(Icons.add, color: theme.colorScheme.background),
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.settings),
                    label: 'Settings',
                    selectedIcon: Icon(Icons.settings,
                        color: theme.colorScheme.background),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
