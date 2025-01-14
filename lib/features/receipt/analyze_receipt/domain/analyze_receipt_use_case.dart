import 'package:grocerlytics/features/receipt/analyze_receipt/data/analyze_receipt_service.dart';
import 'package:grocerlytics/features/receipt/analyze_receipt/models/analyze_receipt_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AnalyzeReceiptUseCase {
  const AnalyzeReceiptUseCase({
    required this.analyzeReceiptService,
  });

  final AnalyzeReceiptService analyzeReceiptService;

  Future<AnalyzeReceiptModel> run(XFile image) async {
    final result = await analyzeReceiptService.run(image);

    return AnalyzeReceiptModel.fromResponse(result);
  }
}
