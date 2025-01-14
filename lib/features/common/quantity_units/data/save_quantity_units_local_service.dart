import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
class SaveQuantityUnitsLocalService {
  const SaveQuantityUnitsLocalService(
    this.service,
  );

  final LocalDatabase service;

  Future<void> run(List<Map<String, dynamic>> quantityUnits) async {
    final batch = service.batch();
    for (var quantityUnit in quantityUnits) {
      batch.insert(
        'quantity_units',
        quantityUnit,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }
}
