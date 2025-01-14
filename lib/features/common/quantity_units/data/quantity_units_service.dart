import 'dart:convert';

import 'package:grocerlytics/features/common/quantity_units/data/quantity_units_response.dart';
import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class QuantityUnitsService {
  const QuantityUnitsService(
    this.service,
  );

  final NetworkService service;

  Future<QuantityUnitsResponse> run() async {
    final result = await service.get(
      NetworkModule.quantityUnits.path,
    );
    final decodedResult = jsonDecode(result.data);

    return QuantityUnitsResponse.fromJson(
      decodedResult ?? [],
    );
  }
}
