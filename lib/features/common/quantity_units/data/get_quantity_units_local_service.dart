import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:grocerlytics/features/common/quantity_units/data/quantity_units_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetQuantityUnitsLocalService {
  const GetQuantityUnitsLocalService(
    this.service,
  );

  final LocalDatabase service;

  Future<List<QuantityUnitResponse>> run() async {
    final result = await service.select('quantity_units');
    return result.map((item) => QuantityUnitResponse.fromJson(item)).toList();
  }
}
