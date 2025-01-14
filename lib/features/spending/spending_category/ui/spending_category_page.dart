import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/auth/ui/auth_cubit.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/features/common/currencies/ui/currencies_cubit.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/quantity_units/ui/quantity_units_cubit.dart';
import 'package:grocerlytics/features/common/ui/animated_container_widget.dart';
import 'package:grocerlytics/features/common/ui/placeholder_widget.dart';
import 'package:grocerlytics/features/common/ui/price_widget.dart';
import 'package:grocerlytics/features/common/ui/shimmer_widget.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';
import 'package:grocerlytics/features/spending/spending_category/models/spending_category_transaction_model.dart';
import 'package:grocerlytics/features/spending/spending_category/ui/spending_category_cubit.dart';
import 'package:grocerlytics/features/utils/intl_utils.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class SpendingCategoryPage extends StatelessWidget {
  const SpendingCategoryPage({
    super.key,
    @PathParam('id') required this.id,
    @PathParam('start_date') required this.startDate,
    @PathParam('end_date') required this.endDate,
    @PathParam('count') required this.count,
  });

  final int id;
  final String startDate;
  final String endDate;
  final int count;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpendingCategoryCubit>(
      create: (_) => getIt.get<SpendingCategoryCubit>()
        ..init(
          context.read<CategoriesCubit>().state.categories.firstWhere(
                (e) => id == e.id,
              ),
          context.read<AuthCubit>().state.user.id,
          startDate,
          endDate,
          context.read<QuantityUnitsCubit>().state.quantities,
          context.read<CurrenciesCubit>().state.currencies,
          count,
        ),
      child: const SpendingCategoryScreen(),
    );
  }
}

class SpendingCategoryScreen extends StatelessWidget {
  const SpendingCategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.select((SpendingCategoryCubit c) => c.state);

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'spending-category${state.categoryModel.id}',
                child: Icon(state.categoryModel.iconData),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.categoryModel.label,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
          leading: const AutoLeadingButton(),
        ),
        body: switch (state.status) {
          InitialStatus<SpendingCategoryState>() ||
          LoadingStatus<SpendingCategoryState>() ||
          LoadedStatus<SpendingCategoryState>() =>
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: ListView.separated(
                    itemCount: state.transactions.length,
                    itemBuilder: (_, index) => _SpendingCategoryTransactionTile(
                      element: state.transactions[index],
                      isLoading: state.status.isLoading,
                    ),
                    separatorBuilder: (_, index) => const Divider(),
                  ),
                ),
              ),
            ),
          ErrorStatus<SpendingCategoryState>() => const Center(
              child: Text('An error has occurred'),
            ),
          EmptyStatus<SpendingCategoryState>() =>
            const _EmptySpendingCategoryPage(),
        });
  }
}

class _SpendingCategoryTransactionTile extends StatelessWidget {
  const _SpendingCategoryTransactionTile({
    required this.element,
    required this.isLoading,
  });

  final SpendingCategoryTransactionModel element;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainerWidget(
                  firstChild: const ShimmerWidget(
                    child: PlaceholderWidget(
                      width: 50,
                    ),
                  ),
                  secondChild: Text(
                    element.itemName,
                    style: theme.textTheme.list.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  isLoading: isLoading,
                ),
                const SizedBox(height: 2),
                AnimatedContainerWidget(
                  firstChild: const ShimmerWidget(
                    child: PlaceholderWidget(
                      width: 40,
                    ),
                  ),
                  secondChild: Text(
                    element.storeName,
                    style: theme.textTheme.small.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  isLoading: isLoading,
                ),
                const SizedBox(height: 2),
                AnimatedContainerWidget(
                  firstChild: const ShimmerWidget(
                    child: PlaceholderWidget(
                      width: 40,
                    ),
                  ),
                  secondChild: Text(
                    formatDateTime(element.purchaseDate.toLocal()),
                    style: theme.textTheme.muted,
                  ),
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              AnimatedContainerWidget(
                firstChild: const ShimmerWidget(
                  child: PlaceholderWidget(
                    width: 60,
                  ),
                ),
                secondChild: PriceWidget(
                  currencyModel: element.priceModel.currencyModel,
                  price: element.priceModel.price,
                ),
                isLoading: isLoading,
              ),
              AnimatedContainerWidget(
                firstChild: const ShimmerWidget(
                    child: PlaceholderWidget(
                  width: 40,
                )),
                secondChild: Text(
                  '${element.quantityModel.quantity.toString()} ${element.quantityModel.quantityUnitModel.shorthand}',
                  style: theme.textTheme.muted,
                ),
                isLoading: isLoading,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptySpendingCategoryPage extends StatelessWidget {
  const _EmptySpendingCategoryPage();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        const Icon(
          LucideIcons.shoppingBasket,
          size: 80,
        ),
        Text(
          'No items exist for this category',
          textAlign: TextAlign.center,
          style: theme.textTheme.muted,
        ),
      ],
    );
  }
}
