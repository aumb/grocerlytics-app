import 'dart:convert';

import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:grocerlytics/features/spending/data/spending_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SpendingService {
  const SpendingService(
    this.service,
  );

  final NetworkService service;

  Future<SpendingResponse> run(
      String userId, String startDate, String endDate) async {
    final result = await service.get(
      '${NetworkModule.receipts.path}/$userId/stats',
      queryParameters: {
        'start_date': startDate,
        'end_date': endDate,
      },
    );

    final decodedResult = jsonDecode(result.data);

    return SpendingResponse.fromJson(decodedResult ?? []);
  }
}
