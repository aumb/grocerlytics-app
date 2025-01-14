import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/receipt/analyze_receipt/data/analyze_receipt_response.dart';

class AnalyzeReceiptModel extends Equatable {
  const AnalyzeReceiptModel({
    required this.storeName,
    required this.items,
  });

  factory AnalyzeReceiptModel.fromResponse(
    AnalyzeReceiptResponse response,
  ) =>
      AnalyzeReceiptModel(
        storeName: response.storeName,
        items:
            response.items.map(AnalyzeReceiptItemModel.fromResponse).toList(),
      );

  final String storeName;
  final List<AnalyzeReceiptItemModel> items;

  @override
  List<Object?> get props => [storeName, items];
}

class AnalyzeReceiptItemModel extends Equatable {
  const AnalyzeReceiptItemModel({
    required this.itemName,
    required this.itemAbrv,
    required this.quantity,
    required this.price,
    required this.categoryId,
    required this.quantityUnitId,
  });

  factory AnalyzeReceiptItemModel.fromResponse(
    AnalyzeReceiptItemResponse response,
  ) =>
      AnalyzeReceiptItemModel(
        itemAbrv: response.itemAbrv,
        itemName: response.itemName,
        quantity: response.quantity,
        price: response.price,
        categoryId: response.categoryId,
        quantityUnitId: response.quantityUnitId,
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
