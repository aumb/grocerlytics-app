import 'package:grocerlytics/features/common/receipt_details/data/receipt_details_item_response.dart';
import 'package:grocerlytics/features/common/receipt_details/data/receipt_details_response.dart';
import 'package:grocerlytics/features/common/receipt_details/data/sync_unassigned_receipts_details_service.dart';
import 'package:grocerlytics/features/common/receipt_details/models/receipt_details_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncUnassignedReceiptsDetailsUseCase {
  const SyncUnassignedReceiptsDetailsUseCase({
    required this.syncUnassignedReceiptsDetailsService,
  });

  final SyncUnassignedReceiptsDetailsService
      syncUnassignedReceiptsDetailsService;

  Future<void> run(List<ReceiptDetailsModel> items, String userId) async {
    final data = items
        .map(
          (e) => ReceiptDetailsResponse(
            id: e.id,
            userId: userId,
            currencyId: e.currencyId,
            storeName: e.storeName,
            totalAmount: e.totalAmount,
            purchaseDate: e.purchaseDate,
            createdAt: e.createdAt,
            items: e.items
                .map(
                  (e) => ReceiptDetailsItemResponse(
                    id: e.id,
                    receiptId: e.receiptId,
                    itemName: e.itemName,
                    itemAbrv: e.itemAbrv,
                    price: e.price,
                    quantity: e.quantity,
                    quantityUnitId: e.quantityUnitId,
                    categoryId: e.categoryId,
                    createdAt: e.createdAt,
                  ),
                )
                .toList(),
          ).toJson,
        )
        .toList();

    return syncUnassignedReceiptsDetailsService.run(data);
  }
}
