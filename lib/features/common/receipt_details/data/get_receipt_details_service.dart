import 'dart:convert';

import 'package:grocerlytics/features/common/receipt_details/data/receipt_details_response.dart';
import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetReceiptDetailsService {
  const GetReceiptDetailsService(
    this.service,
  );

  final NetworkService service;

  Future<List<ReceiptDetailsResponse>> run(String userId) async {
    final result = await service.get(
      '${NetworkModule.receipts.path}/$userId',
      requiresAuth: true,
    );

    final decodedResult = jsonDecode(result.data);

    return (decodedResult as List<dynamic>?)
            ?.map(
              (e) => ReceiptDetailsResponse.fromJson(e),
            )
            .toList() ??
        [];
  }
}
