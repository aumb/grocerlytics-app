import 'package:grocerlytics/features/common/receipt_details/data/unassigned_receipts_details_local_service.dart';
import 'package:grocerlytics/features/common/receipt_details/models/receipt_details_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUnassignedReceiptsDetailsUseCase {
  const GetUnassignedReceiptsDetailsUseCase({
    required this.unassignedReceiptsDetailsLocalService,
  });

  final UnassignedReceiptsDetailsLocalService
      unassignedReceiptsDetailsLocalService;

  Future<List<ReceiptDetailsModel>> run() async {
    final result = await unassignedReceiptsDetailsLocalService.run();

    return result.map(ReceiptDetailsModel.fromResponse).toList();
  }
}
