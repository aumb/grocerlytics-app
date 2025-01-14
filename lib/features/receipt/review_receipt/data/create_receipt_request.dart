import 'package:equatable/equatable.dart';

class CreateReceiptRequestModel extends Equatable {
  const CreateReceiptRequestModel({
    required this.id,
    required this.userId,
    required this.currencyId,
    required this.storeName,
    required this.totalAmount,
    required this.purchaseDate,
    required this.items,
  });

  final String id;
  final String userId;
  final int currencyId;
  final String storeName;
  final double totalAmount;
  final String purchaseDate;
  final List<CreateReceiptItemRequestModel> items;

  Map<String, dynamic> get toJson => {
        'id': id,
        'user_id': userId,
        'currency_id': currencyId,
        'store_name': storeName,
        'total_amount': totalAmount,
        'purchase_date': purchaseDate,
        'items': items
            .map(
              (e) => CreateReceiptItemRequestModel(
                id: e.id,
                receiptId: id,
                itemName: e.itemName,
                itemAbrv: e.itemAbrv,
                price: e.price,
                quantity: e.quantity,
                quantityUnitId: e.quantityUnitId,
                categoryId: e.categoryId,
              ).toJson,
            )
            .toList(),
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        currencyId,
        storeName,
        totalAmount,
        purchaseDate,
        items,
      ];
}

class CreateReceiptItemRequestModel extends Equatable {
  const CreateReceiptItemRequestModel({
    required this.id,
    required this.receiptId,
    required this.itemName,
    required this.itemAbrv,
    required this.price,
    required this.quantity,
    required this.quantityUnitId,
    required this.categoryId,
  });

  final String id;
  final String receiptId;
  final String itemName;
  final String? itemAbrv;
  final double price;
  final double quantity;
  final int quantityUnitId;
  final int categoryId;

  Map<String, dynamic> get toJson => {
        'id': id,
        'receipt_id': receiptId,
        'item_name': itemName,
        'item_abrv': itemAbrv,
        'price': price,
        'quantity': quantity,
        'quantity_unit_id': quantityUnitId,
        'category_id': categoryId,
      };

  @override
  List<Object?> get props => [
        id,
        receiptId,
        itemName,
        price,
        quantity,
        quantityUnitId,
        categoryId,
      ];
}
