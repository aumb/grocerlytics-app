import 'package:equatable/equatable.dart';

class ReceiptItemResponse extends Equatable {
  const ReceiptItemResponse({
    required this.id,
    required this.receiptId,
    required this.itemName,
    required this.price,
    required this.quantity,
    required this.quantityUnitId,
    required this.categoryId,
    required this.createdAt,
  });

  factory ReceiptItemResponse.fromJson(Map<String, dynamic> json) =>
      ReceiptItemResponse(
        id: json['id'] as String,
        receiptId: json['receipt_id'] as String,
        itemName: json['item_name'] as String,
        price: (json['price'] as num).toDouble(),
        quantity: (json['quantity'] as num).toDouble(),
        quantityUnitId: json['quantity_unit_id'] as int,
        categoryId: json['category_id'] as int,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  final String id;
  final String receiptId;
  final String itemName;
  final double price;
  final double quantity;
  final int quantityUnitId;
  final int categoryId;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        id,
        receiptId,
        itemName,
        price,
        quantity,
        quantityUnitId,
        categoryId,
        createdAt,
      ];
}
