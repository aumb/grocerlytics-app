import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncUnassignedReceiptsDetailsService {
  const SyncUnassignedReceiptsDetailsService(
    this.service,
  );

  final NetworkService service;

  Future<void> run(List<Map<String, dynamic>> data) {
    return service.post(
      '${NetworkModule.receipts.path}/bulk',
      requiresAuth: true,
      data: data,
    );
  }
}
