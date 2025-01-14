import 'package:grocerlytics/features/common/receipt_details/data/get_receipt_details_service.dart';
import 'package:grocerlytics/features/common/receipt_details/models/receipt_details_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetReceiptDetailsUseCase {
  const GetReceiptDetailsUseCase({
    required this.getReceiptDetailsService,
  });

  final GetReceiptDetailsService getReceiptDetailsService;

  Future<List<ReceiptDetailsModel>> run(String userId) async {
    final result = await getReceiptDetailsService.run(userId);

    return result.map(ReceiptDetailsModel.fromResponse).toList();
  }
}
