import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:grocerlytics/features/spending/data/spending_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SpendingLocalService {
  const SpendingLocalService({
    required this.localDatabase,
  });

  final LocalDatabase localDatabase;
  Future<SpendingResponse> run({
    required String startDate,
    required String endDate,
    String? userId,
  }) async {
    final totalSpentResult = await localDatabase.rawQuery(
      'SELECT SUM(total_amount) AS total_spent '
      'FROM receipts '
      'WHERE purchase_date BETWEEN ? AND ? '
      'AND (${userId != null ? '(user_id = ? OR user_id IS NULL OR user_id = \'\')' : '1=1'})',
      [
        startDate,
        endDate,
        if (userId != null) userId,
      ],
    );

    final totalSpent = (totalSpentResult.isNotEmpty &&
            totalSpentResult.first['total_spent'] != null)
        ? (totalSpentResult.first['total_spent'] as num).toDouble()
        : 0.0;

    final categoryStatsResult = await localDatabase.rawQuery('''
    SELECT
      c.id AS category_id,
      c.label AS category_name,
      COALESCE(SUM(
        CASE 
          WHEN r.purchase_date BETWEEN ? AND ? 
          AND (
              ${userId != null ? '(r.user_id = ? OR r.user_id IS NULL OR r.user_id = \'\')' : '1=1'}
              )
          THEN ri.price 
          ELSE 0 
        END
      ), 0.0) AS total_amount,
      COALESCE(COUNT(
        CASE 
          WHEN r.purchase_date BETWEEN ? AND ? 
          AND (
              ${userId != null ? '(r.user_id = ? OR r.user_id IS NULL OR r.user_id = \'\')' : '1=1'}
              ) 
          THEN ri.id 
          ELSE NULL 
        END
      ), 0) AS item_count
    FROM categories c
    LEFT JOIN receipt_items ri ON c.id = ri.category_id
    LEFT JOIN receipts r ON ri.receipt_id = r.id
    GROUP BY c.id, c.label
    ORDER BY total_amount DESC
  ''', [
      startDate,
      endDate,
      if (userId != null) userId,
      startDate,
      endDate,
      if (userId != null) userId,
    ]);
    return SpendingResponse.fromJson({
      'total_spent': totalSpent,
      'category_stats': categoryStatsResult,
    });
  }
}
