import 'dart:developer';

import 'package:grocerlytics/features/common/quantity_units/data/get_quantity_units_local_service.dart';
import 'package:grocerlytics/features/common/quantity_units/data/quantity_units_service.dart';
import 'package:grocerlytics/features/common/quantity_units/data/save_quantity_units_local_service.dart';
import 'package:grocerlytics/features/common/quantity_units/models/quantity_unit_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetQuantityUnitsUseCase {
  const GetQuantityUnitsUseCase({
    required this.service,
    required this.getQuantityUnitsLocalService,
    required this.saveQuantityUnitsLocalService,
  });

  final QuantityUnitsService service;
  final GetQuantityUnitsLocalService getQuantityUnitsLocalService;
  final SaveQuantityUnitsLocalService saveQuantityUnitsLocalService;

  Future<List<QuantityUnitModel>> run() async {
    try {
      final localData = await getQuantityUnitsLocalService.run();

      if (localData.isNotEmpty) {
        _syncWithServer();
        return localData.map(QuantityUnitModel.fromResponse).toList();
      }

      return _fetchAndSaveFromServer();
    } catch (e) {
      log(e.toString());
      final localData = await getQuantityUnitsLocalService.run();
      if (localData.isNotEmpty) {
        return localData.map(QuantityUnitModel.fromResponse).toList();
      }
      rethrow;
    }
  }

  Future<List<QuantityUnitModel>> _fetchAndSaveFromServer() async {
    final result = await service.run();
    await saveQuantityUnitsLocalService.run(
      result.quantityUnits.map((e) => e.toJson()).toList(),
    );
    return result.quantityUnits.map(QuantityUnitModel.fromResponse).toList();
  }

  Future<void> _syncWithServer() async {
    try {
      await _fetchAndSaveFromServer();
    } catch (e) {
      log(e.toString());
    }
  }
}
