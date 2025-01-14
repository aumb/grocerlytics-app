import 'package:equatable/equatable.dart';

class AnalyzeReceiptResponse extends Equatable {
  const AnalyzeReceiptResponse({
    required this.storeName,
    required this.items,
  });

  factory AnalyzeReceiptResponse.fromJson(Map<String, dynamic> json) =>
      AnalyzeReceiptResponse(
        storeName: json['store_name'] as String,
        items: (json['items'] as List<dynamic>?)
                ?.map((e) => AnalyzeReceiptItemResponse.fromJson(
                    e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  final String storeName;
  final List<AnalyzeReceiptItemResponse> items;

  @override
  List<Object?> get props => [storeName, items];
}

class AnalyzeReceiptItemResponse extends Equatable {
  const AnalyzeReceiptItemResponse({
    required this.itemName,
    required this.itemAbrv,
    required this.quantity,
    required this.price,
    required this.categoryId,
    required this.quantityUnitId,
  });

  factory AnalyzeReceiptItemResponse.fromJson(Map<String, dynamic> json) =>
      AnalyzeReceiptItemResponse(
        itemAbrv: json['item_abrv'] as String,
        itemName: json['item_name'] as String,
        price: (json['price'] as num).toDouble(),
        quantity: (json['quantity'] as num).toDouble(),
        quantityUnitId: json['quantity_unit_id'] as int,
        categoryId: json['category_id'] as int,
      );

  final String itemName;
  final String itemAbrv;
  final double quantity;
  final double price;
  final int categoryId;
  final int quantityUnitId;

  @override
  List<Object?> get props => [
        itemName,
        itemAbrv,
        quantity,
        price,
        categoryId,
        quantityUnitId,
      ];
}
