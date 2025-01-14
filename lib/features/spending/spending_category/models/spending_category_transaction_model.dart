import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/quantity_units/models/quantity_unit_model.dart';

class SpendingCategoryTransactionModel extends Equatable {
  const SpendingCategoryTransactionModel({
    required this.id,
    required this.storeName,
    required this.itemName,
    required this.quantityModel,
    required this.priceModel,
    required this.purchaseDate,
  });

  final String id;
  final String storeName;
  final String itemName;
  final QuantityModel quantityModel;
  final PriceModel priceModel;
  final DateTime purchaseDate;

  @override
  List<Object?> get props => [
        id,
        storeName,
        itemName,
        quantityModel,
        priceModel,
        purchaseDate,
      ];
}

class PriceModel extends Equatable {
  const PriceModel({
    required this.price,
    required this.currencyModel,
  });

  final double price;
  final CurrencyModel currencyModel;

  PriceModel copyWith({
    double? price,
    CurrencyModel? currencyModel,
  }) =>
      PriceModel(
        price: price ?? this.price,
        currencyModel: currencyModel ?? this.currencyModel,
      );

  @override
  List<Object?> get props => [price, currencyModel];
}

class QuantityModel extends Equatable {
  const QuantityModel({
    required this.quantity,
    required this.quantityUnitModel,
  });

  final double quantity;
  final QuantityUnitModel quantityUnitModel;

  QuantityModel copyWith({
    double? quantity,
    QuantityUnitModel? quantityUnitModel,
  }) =>
      QuantityModel(
        quantity: quantity ?? this.quantity,
        quantityUnitModel: quantityUnitModel ?? this.quantityUnitModel,
      );

  @override
  List<Object?> get props => [quantity, quantityUnitModel];
}
