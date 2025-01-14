import 'package:equatable/equatable.dart';

class CurrenciesResponse extends Equatable {
  const CurrenciesResponse({
    required this.currencies,
  });

  factory CurrenciesResponse.fromJson(List<dynamic> json) => CurrenciesResponse(
        currencies: json.map((e) => CurrencyResponse.fromJson(e)).toList(),
      );

  final List<CurrencyResponse> currencies;

  @override
  List<Object?> get props => [currencies];
}

class CurrencyResponse extends Equatable {
  const CurrencyResponse({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
  });

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) =>
      CurrencyResponse(
        id: json['id'] as int,
        name: json['name'] as String,
        code: json['code'] as String,
        symbol: json['symbol'] as String,
      );

  final int id;
  final String name;
  final String code;
  final String symbol;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
        'symbol': symbol,
      };

  @override
  List<Object?> get props => [id, name, code, symbol];
}
