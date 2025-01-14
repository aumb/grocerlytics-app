import 'dart:developer';

import 'package:grocerlytics/features/common/currencies/data/currencies_service.dart';
import 'package:grocerlytics/features/common/currencies/data/get_currencies_local_service.dart';
import 'package:grocerlytics/features/common/currencies/data/save_currencies_local_service.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCurrenciesUseCase {
  const GetCurrenciesUseCase({
    required this.service,
    required this.saveCurrenciesLocalService,
    required this.getCurrenciesLocalService,
  });

  final CurrenciesService service;
  final SaveCurrenciesLocalService saveCurrenciesLocalService;
  final GetCurrenciesLocalService getCurrenciesLocalService;

  Future<List<CurrencyModel>> run() async {
    try {
      final localData = await getCurrenciesLocalService.run();

      if (localData.isNotEmpty) {
        _syncWithServer();
        return localData.map(CurrencyModel.fromResponse).toList();
      }

      return _fetchAndSaveFromServer();
    } catch (e) {
      log(e.toString());
      final localData = await getCurrenciesLocalService.run();
      if (localData.isNotEmpty) {
        return localData.map(CurrencyModel.fromResponse).toList();
      }
      rethrow;
    }
  }

  Future<List<CurrencyModel>> _fetchAndSaveFromServer() async {
    final result = await service.run();
    await saveCurrenciesLocalService.run(
      result.currencies.map((e) => e.toJson()).toList(),
    );
    return result.currencies.map(CurrencyModel.fromResponse).toList();
  }

  Future<void> _syncWithServer() async {
    try {
      await _fetchAndSaveFromServer();
    } catch (e) {
      log(e.toString());
    }
  }
}
