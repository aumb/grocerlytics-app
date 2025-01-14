import 'package:equatable/equatable.dart';

class CreateReceiptModel extends Equatable {
  const CreateReceiptModel({
    required this.userId,
    required this.currencyId,
    required this.storeName,
    required this.totalAmount,
    required this.purchaseDate,
    required this.items,
  });

  final String userId;
  final int currencyId;
  final String storeName;
  final double totalAmount;
  final String purchaseDate;
  final List<CreateReceiptItemModel> items;

  @override
  List<Object?> get props => [
        userId,
        currencyId,
        storeName,
        totalAmount,
        purchaseDate,
        items,
      ];
}

class CreateReceiptItemModel extends Equatable {
  const CreateReceiptItemModel({
    required this.itemName,
    required this.itemAbrv,
    required this.price,
    required this.quantity,
    required this.quantityUnitId,
    required this.categoryId,
  });

  final String itemName;
  final String? itemAbrv;
  final double price;
  final double quantity;
  final int quantityUnitId;
  final int categoryId;

  @override
  List<Object?> get props => [
        itemName,
        itemAbrv,
        price,
        quantity,
        quantityUnitId,
        categoryId,
      ];
}
