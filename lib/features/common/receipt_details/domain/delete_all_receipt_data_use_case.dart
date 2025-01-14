import 'package:grocerlytics/features/common/local_storage/local_storage.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage_keys.dart';
import 'package:grocerlytics/features/common/receipt_details/data/delete_all_receipt_data_local_service.dart';
import 'package:grocerlytics/features/common/receipt_details/data/delete_all_receipt_data_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteAllReceiptDataUseCase {
  const DeleteAllReceiptDataUseCase({
    required this.deleteAllReceiptDataLocalService,
    required this.deleteAllReceiptDataService,
    required this.localStorage,
  });

  final DeleteAllReceiptDataLocalService deleteAllReceiptDataLocalService;
  final DeleteAllReceiptDataService deleteAllReceiptDataService;
  final LocalStorage localStorage;

  Future<void> run(String userId) async {
    if (userId.isNotEmpty) {
      await deleteAllReceiptDataService.run(userId);
    }
    await Future.wait([
      localStorage.removeValue(LocalStorageKeys.accessToken),
      localStorage.removeValue(LocalStorageKeys.refreshToken),
      localStorage.removeValue(LocalStorageKeys.userId),
    ]);

    await deleteAllReceiptDataLocalService.run();
  }
}
