import 'dart:developer';

import 'package:grocerlytics/features/common/categories/data/categories_service.dart';
import 'package:grocerlytics/features/common/categories/data/get_categories_local_service.dart';
import 'package:grocerlytics/features/common/categories/data/save_categories_local_service.dart';
import 'package:grocerlytics/features/common/categories/models/category_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCategoriesUseCase {
  const GetCategoriesUseCase({
    required this.service,
    required this.getCategoriesLocalService,
    required this.saveCategoriesLocalService,
  });

  final CategoriesService service;
  final GetCategoriesLocalService getCategoriesLocalService;
  final SaveCategoriesLocalService saveCategoriesLocalService;

  Future<List<CategoryModel>> run() async {
    try {
      final localData = await getCategoriesLocalService.run();

      if (localData.isNotEmpty) {
        _syncWithServer();
        return localData.map(CategoryModel.fromResponse).toList();
      }

      return _fetchAndSaveFromServer();
    } catch (e) {
      log(e.toString());
      final localData = await getCategoriesLocalService.run();
      if (localData.isNotEmpty) {
        return localData.map(CategoryModel.fromResponse).toList();
      }
      rethrow;
    }
  }

  Future<List<CategoryModel>> _fetchAndSaveFromServer() async {
    final result = await service.run();
    await saveCategoriesLocalService.run(
      result.categories.map((e) => e.toJson()).toList(),
    );
    return result.categories.map(CategoryModel.fromResponse).toList();
  }

  Future<void> _syncWithServer() async {
    try {
      await _fetchAndSaveFromServer();
    } catch (e) {
      log(e.toString());
    }
  }
}
