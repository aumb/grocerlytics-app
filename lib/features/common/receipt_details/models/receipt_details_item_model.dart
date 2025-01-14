import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/common/receipt_details/data/receipt_details_item_response.dart';

class ReceiptDetailsItemModel extends Equatable {
  const ReceiptDetailsItemModel({
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

  factory ReceiptDetailsItemModel.fromJson(
          ReceiptDetailsItemResponse response) =>
      ReceiptDetailsItemModel(
        id: response.id,
        receiptId: response.receiptId,
        itemName: response.itemName,
        itemAbrv: response.itemAbrv,
        price: response.price,
        quantity: response.quantity,
        quantityUnitId: response.quantityUnitId,
        categoryId: response.categoryId,
        createdAt: response.createdAt,
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
