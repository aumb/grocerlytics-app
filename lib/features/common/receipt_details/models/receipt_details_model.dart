import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/common/receipt_details/data/receipt_details_response.dart';
import 'package:grocerlytics/features/common/receipt_details/models/receipt_details_item_model.dart';

class ReceiptDetailsModel extends Equatable {
  const ReceiptDetailsModel({
    required this.id,
    required this.userId,
    required this.currencyId,
    required this.storeName,
    required this.totalAmount,
    required this.purchaseDate,
    required this.createdAt,
    required this.items,
  });

  factory ReceiptDetailsModel.fromResponse(ReceiptDetailsResponse response) =>
      ReceiptDetailsModel(
        id: response.id,
        userId: response.userId,
        currencyId: response.currencyId,
        storeName: response.storeName,
        totalAmount: response.totalAmount,
        purchaseDate: response.purchaseDate,
        createdAt: response.createdAt,
        items: response.items.map(ReceiptDetailsItemModel.fromJson).toList(),
      );

  final String id;
  final String? userId;
  final int currencyId;
  final String storeName;
  final double totalAmount;
  final DateTime purchaseDate;
  final DateTime createdAt;
  final List<ReceiptDetailsItemModel> items;

  @override
  List<Object?> get props => [
        id,
        userId,
        currencyId,
        storeName,
        totalAmount,
        purchaseDate,
        createdAt,
        items,
      ];
}
