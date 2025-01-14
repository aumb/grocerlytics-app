import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/common/categories/models/category_model.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/quantity_units/models/quantity_unit_model.dart';

class ReceiptItemModel extends Equatable {
  const ReceiptItemModel({
    required this.id,
    this.name,
    this.itemAbrv,
    this.categoryModel,
    this.quantityModel,
    this.priceModel,
  });

  final String id;
  final String? name;
  final String? itemAbrv;
  final CategoryModel? categoryModel;
  final ReceiptItemQuantityModel? quantityModel;
  final ReceiptItemPriceModel? priceModel;

  @override
  List<Object?> get props => [
        id,
        name,
        itemAbrv,
        categoryModel,
        quantityModel,
        priceModel,
      ];
}

class ReceiptItemQuantityModel extends Equatable {
  const ReceiptItemQuantityModel({
    required this.quantity,
    required this.unit,
  });

  final double quantity;
  final QuantityUnitModel unit;

  ReceiptItemQuantityModel copyWith({
    double? quantity,
    QuantityUnitModel? unit,
  }) =>
      ReceiptItemQuantityModel(
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
      );

  @override
  List<Object?> get props => [quantity, unit];
}

class ReceiptItemPriceModel extends Equatable {
  const ReceiptItemPriceModel({
    required this.price,
    required this.unit,
  });

  final double price;
  final CurrencyModel unit;

  ReceiptItemPriceModel copyWith({
    double? price,
    CurrencyModel? unit,
  }) =>
      ReceiptItemPriceModel(
        price: price ?? this.price,
        unit: unit ?? this.unit,
      );

  @override
  List<Object?> get props => [price, unit];
}
