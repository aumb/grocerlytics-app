import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
class SaveReceiptDetailsLocalService {
  const SaveReceiptDetailsLocalService({
    required this.localDatabase,
  });

  final LocalDatabase localDatabase;

  Future<void> run(List<Map<String, dynamic>> receiptDetails) async {
    final batch = localDatabase.batch();

    for (var receiptData in receiptDetails) {
      final items = List<Map<String, dynamic>>.from(receiptData['items']);
      receiptData.remove('items');

      batch.insert(
        'receipts',
        receiptData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      for (var item in items) {
        batch.insert(
          'receipt_items',
          item,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    await batch.commit(noResult: true);
  }
}
