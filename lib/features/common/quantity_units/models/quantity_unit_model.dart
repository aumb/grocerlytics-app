import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/common/quantity_units/data/quantity_units_response.dart';

class QuantityUnitModel extends Equatable {
  const QuantityUnitModel({
    required this.id,
    required this.shorthand,
    required this.name,
  });

  factory QuantityUnitModel.fromResponse(QuantityUnitResponse response) =>
      QuantityUnitModel(
        id: response.id,
        name: response.name,
        shorthand: response.shorthand,
      );

  final int id;
  final String shorthand;
  final String name;

  @override
  List<Object?> get props => [id, shorthand, name];
}
