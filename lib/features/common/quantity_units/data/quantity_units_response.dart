import 'package:equatable/equatable.dart';

class QuantityUnitsResponse extends Equatable {
  const QuantityUnitsResponse({
    required this.quantityUnits,
  });

  factory QuantityUnitsResponse.fromJson(List<dynamic> json) =>
      QuantityUnitsResponse(
        quantityUnits:
            json.map((e) => QuantityUnitResponse.fromJson(e)).toList(),
      );

  final List<QuantityUnitResponse> quantityUnits;

  @override
  List<Object?> get props => [quantityUnits];
}

class QuantityUnitResponse extends Equatable {
  const QuantityUnitResponse({
    required this.id,
    required this.name,
    required this.shorthand,
  });

  factory QuantityUnitResponse.fromJson(Map<String, dynamic> json) =>
      QuantityUnitResponse(
        id: json['id'] as int,
        name: json['name'] as String,
        shorthand: json['shorthand'] as String,
      );

  final int id;
  final String name;
  final String shorthand;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'shorthand': shorthand,
      };

  @override
  List<Object?> get props => [id, name, shorthand];
}
