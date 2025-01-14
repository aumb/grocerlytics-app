import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateReceiptLocalService {
  const CreateReceiptLocalService({
    required this.localDatabase,
  });

  final LocalDatabase localDatabase;

  Future<void> run({
    required String receiptId,
    required String? userId,
    required int? currencyId,
    required double totalAmount,
    required String? storeName,
    required String purchaseDate,
    required List<Map<String, dynamic>> items,
  }) async =>
      localDatabase.database.transaction((txn) async {
        await txn.insert(
          'receipts',
          {
            'id': receiptId,
            'user_id': userId,
            'currency_id': currencyId,
            'store_name': storeName,
            'total_amount': totalAmount,
            'purchase_date': purchaseDate,
            'created_at': DateTime.now().toUtc().toIso8601String(),
          },
        );

        for (final item in items) {
          await txn.insert('receipt_items', {
            'id': item['id'],
            'receipt_id': receiptId,
            'item_name': item['item_name'],
            'price': item['price'],
            'quantity': item['quantity'],
            'quantity_unit_id': item['quantity_unit_id'],
            'category_id': item['category_id'],
            'created_at': DateTime.now().toUtc().toIso8601String(),
            'item_abrv': item['item_abrv'],
          });
        }
      });
}
