import 'package:flutter/widgets.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/spending/spending_categories/model/spending_category_model.dart';
import 'package:grocerlytics/features/spending/spending_categories/ui/widgets/spending_category_list_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpendingCategoriesPanel extends StatelessWidget {
  const SpendingCategoriesPanel({
    super.key,
    required this.isLoading,
    required this.spendingCategories,
    required this.selectedCategoryIndex,
    required this.itemScrollController,
    required this.selectedCurrency,
    required this.startDate,
    required this.endDate,
  });

  final bool isLoading;
  final List<SpendingCategoryModel> spendingCategories;
  final int selectedCategoryIndex;
  final ItemScrollController itemScrollController;
  final CurrencyModel selectedCurrency;
  final String startDate;
  final String endDate;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadDecorator(
      decoration: ShadDecoration(
        merge: false,
        color: theme.colorScheme.secondary,
        border: const ShadBorder(
          radius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            topLeft: Radius.circular(32),
          ),
        ),
        shadows: [
          BoxShadow(
            color: theme.colorScheme.primary.withAlpha(30),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Text(
              'Spending Categories',
              style: ShadTheme.of(context).textTheme.large,
            ),
          ),
          Expanded(
            child: SpendingCategoryListWidget(
              isLoading: isLoading,
              spendingCategories: spendingCategories,
              selectedCategoryIndex: selectedCategoryIndex,
              itemScrollController: itemScrollController,
              selectedCurrency: selectedCurrency,
              startDate: startDate,
              endDate: endDate,
            ),
          ),
        ],
      ),
    );
  }
}
