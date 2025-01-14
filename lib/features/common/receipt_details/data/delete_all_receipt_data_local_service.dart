import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteAllReceiptDataLocalService {
  const DeleteAllReceiptDataLocalService({
    required this.localDatabase,
  });

  final LocalDatabase localDatabase;

  Future<void> run() => localDatabase.transaction((txn) async {
        await txn.delete('receipt_items');
        await txn.delete('receipts');
      });
}
