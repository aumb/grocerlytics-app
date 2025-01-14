import 'package:flutter/widgets.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/spending/spending_categories/model/spending_category_model.dart';
import 'package:grocerlytics/features/spending/spending_categories/ui/widgets/spending_category_tile.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SpendingCategoryListWidget extends StatelessWidget {
  const SpendingCategoryListWidget({
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
    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      itemCount: spendingCategories.length,
      itemBuilder: (context, index) => SpendingCategoryTile(
        startDate: startDate,
        endDate: endDate,
        isLoading: isLoading,
        selectedCurrency: selectedCurrency,
        spendingCategoryModel: spendingCategories[index],
        backgroundColor: selectedCategoryIndex == index
            ? spendingCategories[index].categoryModel.color
            : null,
      ),
    );
  }
}
