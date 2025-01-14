import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:grocerlytics/features/common/receipt_details/data/receipt_details_item_response.dart';
import 'package:grocerlytics/features/common/receipt_details/data/receipt_details_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UnassignedReceiptsDetailsLocalService {
  const UnassignedReceiptsDetailsLocalService({
    required this.localDatabase,
  });

  final LocalDatabase localDatabase;

  Future<List<ReceiptDetailsResponse>> run() async {
    final result = await localDatabase.rawQuery('''
    SELECT
      r.id,
      r.user_id,
      r.currency_id,
      r.store_name,
      r.total_amount,
      r.purchase_date,
      r.created_at,
      ri.id as item_id,
      ri.item_name as item_name,
      ri.price as item_price, 
      ri.quantity as item_quantity,
      ri.quantity_unit_id as item_quantity_unit_id,
      ri.category_id as item_category_id,
      ri.created_at as item_created_at,
      ri.item_abrv as item_abrv
    FROM receipts r
    LEFT JOIN receipt_items ri ON r.id = ri.receipt_id
    WHERE r.user_id IS NULL OR r.user_id = '';
  ''');

    Map<String, ReceiptDetailsResponse> receiptsMap = {};

    for (var row in result) {
      final receiptId = row['id'] as String;

      // Create the receipt if it doesn't exist in the map
      if (!receiptsMap.containsKey(receiptId)) {
        receiptsMap[receiptId] = ReceiptDetailsResponse.fromJson(row);
      }

      // Add the item if it exists (LEFT JOIN can return null for item columns)
      if (row['item_id'] != null) {
        final itemRow = {
          'id': row['item_id'],
          'receipt_id': receiptId,
          'item_name': row['item_name'],
          'item_abrv': row['item_abrv'],
          'price': row['item_price'],
          'quantity': row['item_quantity'],
          'quantity_unit_id': row['item_quantity_unit_id'],
          'category_id': row['item_category_id'],
          'created_at': row['created_at'],
        };

        receiptsMap[receiptId]!
            .items
            .add(ReceiptDetailsItemResponse.fromJson(itemRow));
      }
    }

    return receiptsMap.values.toList();
  }
}
