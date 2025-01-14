import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:grocerlytics/features/receipt/analyze_receipt/data/analyze_receipt_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

@lazySingleton
class AnalyzeReceiptService {
  const AnalyzeReceiptService(
    this.service,
  );

  final NetworkService service;

  Future<AnalyzeReceiptResponse> run(XFile file) async {
    final mimeType = lookupMimeType(file.path) ?? '';

    final image = await MultipartFile.fromFile(
      file.path,
      filename: file.name,
      contentType: DioMediaType.parse(mimeType),
    );

    final formData = FormData.fromMap({
      "image": image,
    });

    final result = await service.post(
      '${NetworkModule.receipts.path}/analyze-receipts',
      data: formData,
    );
    final decodedResult = jsonDecode(result.data);

    return AnalyzeReceiptResponse.fromJson(decodedResult);
  }
}
