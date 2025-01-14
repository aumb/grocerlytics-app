import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/router/router.gr.dart';

class SpendingCategoryGuard extends AutoRouteGuard {
  SpendingCategoryGuard();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final productId = resolver.route.pathParams.getInt('id', 0);
    final productExists = router.navigatorKey.currentContext!
            .read<CategoriesCubit>()
            .state
            .categories
            .firstWhereOrNull((e) => e.id == productId) !=
        null;

    if (productExists) {
      resolver.next(true);
    } else {
      resolver.redirect(const NotFoundRoute());
    }
  }
}
