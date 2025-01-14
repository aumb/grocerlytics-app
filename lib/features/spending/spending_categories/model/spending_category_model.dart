import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/common/categories/models/category_model.dart';

class SpendingCategoryModel extends Equatable {
  const SpendingCategoryModel({
    required this.categoryModel,
    required this.spendingPercentage,
    required this.spendingAmount,
    required this.purchaseCount,
  });

  final CategoryModel categoryModel;
  final double spendingAmount;
  final int spendingPercentage;
  final int purchaseCount;

  @override
  List<Object?> get props => [
        categoryModel,
        spendingAmount,
        spendingPercentage,
        purchaseCount,
      ];
}
