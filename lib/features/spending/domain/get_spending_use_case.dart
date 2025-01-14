import 'dart:isolate';

import 'package:grocerlytics/features/common/categories/models/category_model.dart';
import 'package:grocerlytics/features/spending/data/spending_local_service.dart';
import 'package:grocerlytics/features/spending/models/spending_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSpendingUseCase {
  const GetSpendingUseCase({
    required this.spendingLocalService,
  });

  final SpendingLocalService spendingLocalService;

  Future<SpendingModel> run(
    String userId,
    String startDate,
    String endDate,
    List<CategoryModel> categoryModels,
  ) async {
    final result = await spendingLocalService.run(
      startDate: startDate,
      endDate: endDate,
      userId: userId,
    );

    final receivePort = ReceivePort();
    await Isolate.spawn(
      (Map<String, dynamic> message) async {
        final SendPort sendPort = message['sendPort'];
        final data = message['data'];
        final spending = _isolateFunction(data);
        sendPort.send(spending);
      },
      {
        'sendPort': receivePort.sendPort,
        'data': {
          'response': result,
          'categoryModels': categoryModels,
        },
      },
    );

    final spending = await receivePort.first as SpendingModel;

    return spending;
  }

  static SpendingModel _isolateFunction(Map<String, dynamic> data) {
    final response = data['response'];
    final categoryModels = data['categoryModels'];
    return SpendingModel.fromResponse(response, categoryModels);
  }
}
