import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/ui/bottom_sheet_widget.dart';
import 'package:grocerlytics/features/spending/spending_categories/model/spending_category_model.dart';
import 'package:grocerlytics/features/spending/spending_categories/ui/widgets/spending_category_list_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpendingCategoriesBottomSheet extends StatelessWidget {
  const SpendingCategoriesBottomSheet({
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
    return Center(
      child: DraggableScrollableSheet(
        initialChildSize: 0.25,
        minChildSize: 0.1,
        maxChildSize: .9,
        shouldCloseOnMinExtent: false,
        builder: (_, controller) => DraggableBottomSheetWidget(
          scrollController: controller,
          persistentHeaderDelegate: _SpendingCategoriesHeaderDelegate(),
          child: SliverFillRemaining(
            child: SpendingCategoryListWidget(
              isLoading: isLoading,
              selectedCurrency: selectedCurrency,
              spendingCategories: spendingCategories,
              selectedCategoryIndex: selectedCategoryIndex,
              itemScrollController: itemScrollController,
              startDate: startDate,
              endDate: endDate,
            ),
          ),
        ),
      ),
    );
  }
}

class _SpendingCategoriesHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SpendingCategoriesHeaderDelegate();

  static const sizedBoxHeight = 8;
  static const containerHeight = 4;

  /// font size (large) * font height
  static const fontSizeCalc = 18 * (28 / 18);
  static const fontVerticalPadding = 16 * 2;

  final extents =
      sizedBoxHeight + containerHeight + fontSizeCalc + fontVerticalPadding;

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    final theme = ShadTheme.of(context);

    return ShadDecorator(
      decoration: ShadDecoration(
        merge: false,
        color: theme.colorScheme.secondary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Center(
            child: ShadDecorator(
              decoration: ShadDecoration(
                merge: false,
                border: ShadBorder(
                  radius: BorderRadius.circular(32),
                ),
                color: theme.colorScheme.background,
              ),
              child: const SizedBox(
                height: 4,
                width: 32,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Text(
              'Spending Categories',
              style: theme.textTheme.large,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => extents;

  @override
  double get minExtent => extents;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
