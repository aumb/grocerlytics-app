import 'package:auto_route/auto_route.dart';
import 'package:grocerlytics/router/guards/spending_category_guard.dart';
import 'package:grocerlytics/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(path: 'spending', page: SpendingRoute.page),
            AutoRoute(path: 'empty', page: EmptyRoute.page),
            AutoRoute(path: 'settings', page: SettingsRoute.page),
          ],
        ),
        AutoRoute(
          path: '/spending-categories/:id',
          page: SpendingCategoryRoute.page,
          guards: [SpendingCategoryGuard()],
        ),
        AutoRoute(
          path: '/theme',
          page: ThemeRoute.page,
        ),
        AutoRoute(
          path: '/login',
          page: SignInNavigationRoute.page,
          children: [
            AutoRoute(page: SignInRoute.page, initial: true),
            AutoRoute(path: 'otp', page: VerifyOtpSignInRoute.page),
          ],
        ),
        AutoRoute(
          path: '/add',
          page: AddReceiptNavigationRoute.page,
          children: [
            AutoRoute(page: AddReceiptRoute.page, initial: true),
            AutoRoute(path: 'analyze', page: AnalyzeReceiptRoute.page),
            AutoRoute(path: 'review', page: ReviewReceiptRoute.page),
          ],
        ),
        AutoRoute(page: NotFoundRoute.page, path: '*')
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}
