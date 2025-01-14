import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/common/models/receipt/receipt_item_response.dart';
import 'package:grocerlytics/features/common/models/receipt/receipt_response.dart';

class SpendingCategoryItemsResponse extends Equatable {
  const SpendingCategoryItemsResponse({
    required this.categoryItems,
  });

  factory SpendingCategoryItemsResponse.fromJson(List<dynamic> json) =>
      SpendingCategoryItemsResponse(
        categoryItems: (json as List<dynamic>?)
                ?.map((e) => SpendingCategoryItemResponse.fromJson(e))
                .toList() ??
            [],
      );

  final List<SpendingCategoryItemResponse> categoryItems;

  @override
  List<Object?> get props => [categoryItems];
}

class SpendingCategoryItemResponse extends Equatable {
  const SpendingCategoryItemResponse({
    required this.receipt,
    required this.items,
  });

  factory SpendingCategoryItemResponse.fromJson(Map<String, dynamic> json) =>
      SpendingCategoryItemResponse(
        receipt: ReceiptResponse.fromJson(json['receipt']),
        items: (json['items'] as List<dynamic>?)
                ?.map((e) =>
                    ReceiptItemResponse.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  final ReceiptResponse receipt;
  final List<ReceiptItemResponse> items;

  @override
  List<Object?> get props => [
        receipt,
        items,
      ];
}
