import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:grocerlytics/features/spending/spending_category/data/spending_category_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SpendingCategoryLocalService {
  const SpendingCategoryLocalService({
    required this.localDatabase,
  });

  final LocalDatabase localDatabase;

  Future<SpendingCategoryItemsResponse> run(
    String? userId,
    int categoryId,
    String startDate,
    String endDate,
  ) async {
    final List<Map<String, dynamic>> receiptItems =
        await localDatabase.rawQuery('''
    SELECT ri.*, r.*
    FROM receipt_items ri
    JOIN receipts r ON ri.receipt_id = r.id
    WHERE r.purchase_date >= ? 
    AND r.purchase_date <= ?
    AND ri.category_id = ?
    AND (${userId != null ? '(r.user_id = ? OR r.user_id IS NULL OR r.user_id = \'\')' : '1=1'})
  ''', [
      startDate,
      endDate,
      categoryId,
      if (userId != null) userId,
    ]);

    final Map<String, Map<String, dynamic>> groupedReceipts = {};

    for (final item in receiptItems) {
      final receiptId = item['receipt_id'];
      if (!groupedReceipts.containsKey(receiptId)) {
        groupedReceipts[receiptId] = {
          'receipt': {
            'id': item['id'],
            'currency_id': item['currency_id'],
            'store_name': item['store_name'],
            'total_amount': item['total_amount'],
            'purchase_date': item['purchase_date'],
            'created_at': item['created_at'],
          },
          'items': [],
        };
      }

      groupedReceipts[receiptId]!['items'].add({
        'id': item['id'],
        'receipt_id': item['receipt_id'],
        'item_name': item['item_name'],
        'price': item['price'],
        'quantity': item['quantity'],
        'quantity_unit_id': item['quantity_unit_id'],
        'category_id': item['category_id'],
        'created_at': item['created_at'],
      });
    }

    return SpendingCategoryItemsResponse.fromJson(
        groupedReceipts.values.toList());
  }
}
