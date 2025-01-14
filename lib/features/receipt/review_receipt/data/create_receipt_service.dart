import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateReceiptService {
  const CreateReceiptService(
    this.service,
  );

  final NetworkService service;

  Future<void> run(Map<String, dynamic> data) {
    return service.post(
      NetworkModule.receipts.path,
      requiresAuth: true,
      data: data,
    );
  }
}
