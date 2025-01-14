import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
class SaveCurrenciesLocalService {
  const SaveCurrenciesLocalService(
    this.service,
  );

  final LocalDatabase service;

  Future<void> run(List<Map<String, dynamic>> currencies) async {
    final batch = service.batch();
    for (var currnecy in currencies) {
      batch.insert(
        'currencies',
        currnecy,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }
}
