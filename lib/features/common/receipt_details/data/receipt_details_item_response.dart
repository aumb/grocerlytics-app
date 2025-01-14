import 'package:equatable/equatable.dart';

class ReceiptDetailsItemResponse extends Equatable {
  const ReceiptDetailsItemResponse({
    required this.id,
    required this.receiptId,
    required this.itemName,
    required this.itemAbrv,
    required this.price,
    required this.quantity,
    required this.quantityUnitId,
    required this.categoryId,
    required this.createdAt,
  });

  factory ReceiptDetailsItemResponse.fromJson(Map<String, dynamic> json) =>
      ReceiptDetailsItemResponse(
        id: json['id'] as String,
        receiptId: json['receipt_id'] as String,
        itemName: json['item_name'] as String,
        itemAbrv: json['item_abrv'] as String?,
        price: (json['price'] as num).toDouble(),
        quantity: (json['quantity'] as num).toDouble(),
        quantityUnitId: json['quantity_unit_id'] as int,
        categoryId: json['category_id'] as int,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  final String id;
  final String receiptId;
  final String itemName;
  final String? itemAbrv;
  final double price;
  final double quantity;
  final int quantityUnitId;
  final int categoryId;
  final DateTime createdAt;

  Map<String, dynamic> get toJson => {
        'id': id,
        'receipt_id': receiptId,
        'item_name': itemName,
        'item_abrv': itemAbrv,
        'price': price.toDouble(),
        'quantity': quantity.toDouble(),
        'quantity_unit_id': quantityUnitId,
        'category_id': categoryId,
        'created_at': createdAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        receiptId,
        itemName,
        itemAbrv,
        price,
        quantity,
        quantityUnitId,
        categoryId,
        createdAt,
      ];
}
