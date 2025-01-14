import 'dart:convert';

import 'package:grocerlytics/features/common/categories/data/categories_response.dart';
import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CategoriesService {
  const CategoriesService(
    this.service,
  );

  final NetworkService service;

  Future<CategoriesResponse> run() async {
    final result = await service.get(
      NetworkModule.categories.path,
    );
    final decodedResult = jsonDecode(result.data);

    return CategoriesResponse.fromJson(
      decodedResult ?? [],
    );
  }
}
