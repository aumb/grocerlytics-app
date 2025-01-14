import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/common/categories/models/category_model.dart';
import 'package:grocerlytics/features/spending/data/spending_response.dart';
import 'package:grocerlytics/features/spending/spending_categories/model/spending_category_model.dart';

class SpendingModel extends Equatable {
  const SpendingModel({
    required this.totalSpendingAmount,
    required this.categories,
  });

  factory SpendingModel.fromResponse(
          SpendingResponse response, List<CategoryModel> categoryModels) =>
      SpendingModel(
        totalSpendingAmount: response.totalSpendingAmount,
        categories: response.categories
            .map(
              (e) => SpendingCategoryModel(
                  categoryModel: categoryModels.firstWhere((m) => m.id == e.id),
                  spendingAmount: e.totalAmount,
                  purchaseCount: e.totalCount,
                  spendingPercentage: e.totalAmount == 0 ||
                          response.totalSpendingAmount == 0
                      ? 0
                      : ((e.totalAmount / response.totalSpendingAmount) * 100)
                          .toInt()),
            )
            .toList(),
      );

  final double totalSpendingAmount;
  final List<SpendingCategoryModel> categories;

  @override
  List<Object?> get props => [totalSpendingAmount, categories];
}
