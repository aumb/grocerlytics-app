import 'dart:convert';

import 'package:grocerlytics/features/common/currencies/data/currencies_response.dart';
import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CurrenciesService {
  const CurrenciesService(
    this.service,
  );

  final NetworkService service;

  Future<CurrenciesResponse> run() async {
    final result = await service.get(
      NetworkModule.currencies.path,
    );
    final decodedResult = jsonDecode(result.data);

    return CurrenciesResponse.fromJson(
      decodedResult ?? [],
    );
  }
}
