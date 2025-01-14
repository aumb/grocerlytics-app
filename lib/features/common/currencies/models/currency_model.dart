import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/common/currencies/data/currencies_response.dart';

class CurrencyModel extends Equatable {
  const CurrencyModel({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
  });

  factory CurrencyModel.fromResponse(CurrencyResponse response) =>
      CurrencyModel(
        id: response.id,
        name: response.name,
        code: response.code,
        symbol: response.symbol,
      );

  final int id;
  final String name;
  final String code;
  final String symbol;

  @override
  List<Object?> get props => [id, name, code, symbol];
}
