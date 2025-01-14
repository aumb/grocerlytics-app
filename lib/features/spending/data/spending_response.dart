import 'package:equatable/equatable.dart';

class SpendingResponse extends Equatable {
  const SpendingResponse({
    required this.totalSpendingAmount,
    required this.categories,
  });

  factory SpendingResponse.fromJson(Map<String, dynamic> json) =>
      SpendingResponse(
        totalSpendingAmount: (json['total_spent'] as num).toDouble(),
        categories: (json['category_stats'] as List<dynamic>?)
                ?.map((e) => SpendingCategoryResponse.fromJson(e))
                .toList() ??
            [],
      );

  final double totalSpendingAmount;
  final List<SpendingCategoryResponse> categories;

  @override
  List<Object?> get props => [
        totalSpendingAmount,
        categories,
      ];
}

class SpendingCategoryResponse extends Equatable {
  const SpendingCategoryResponse({
    required this.id,
    required this.totalAmount,
    required this.totalCount,
  });

  factory SpendingCategoryResponse.fromJson(Map<String, dynamic> json) =>
      SpendingCategoryResponse(
        id: json['category_id'] as int,
        totalCount: json['item_count'] as int,
        totalAmount: (json['total_amount'] as num).toDouble(),
      );

  final int id;
  final int totalCount;
  final double totalAmount;

  @override
  List<Object?> get props => [
        id,
        totalAmount,
        totalCount,
      ];
}
