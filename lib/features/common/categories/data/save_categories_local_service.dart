import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
class SaveCategoriesLocalService {
  const SaveCategoriesLocalService(
    this.service,
  );

  final LocalDatabase service;

  Future<void> run(List<Map<String, dynamic>> categories) async {
    final batch = service.batch();
    for (var category in categories) {
      batch.insert(
        'categories',
        category,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }
}
