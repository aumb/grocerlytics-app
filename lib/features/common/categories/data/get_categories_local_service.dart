import 'package:grocerlytics/features/common/categories/data/categories_response.dart';
import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCategoriesLocalService {
  const GetCategoriesLocalService(
    this.service,
  );

  final LocalDatabase service;

  Future<List<CategoryResponse>> run() async {
    final result = await service.select('categories');
    return result.map((item) => CategoryResponse.fromJson(item)).toList();
  }
}
