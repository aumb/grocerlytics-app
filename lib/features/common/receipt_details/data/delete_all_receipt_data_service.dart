import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteAllReceiptDataService {
  const DeleteAllReceiptDataService(
    this.service,
  );

  final NetworkService service;

  Future<void> run(String userId) => service.delete(
        '${NetworkModule.receipts.path}/$userId/all',
        requiresAuth: true,
      );
}
