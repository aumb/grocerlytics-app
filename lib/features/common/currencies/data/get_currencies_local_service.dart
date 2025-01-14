import 'package:grocerlytics/features/common/currencies/data/currencies_response.dart';
import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCurrenciesLocalService {
  const GetCurrenciesLocalService(
    this.service,
  );

  final LocalDatabase service;

  Future<List<CurrencyResponse>> run() async {
    final result = await service.select('currencies');
    return result.map((item) => CurrencyResponse.fromJson(item)).toList();
  }
}
