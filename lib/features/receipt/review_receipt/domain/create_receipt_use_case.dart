import 'dart:isolate';

import 'package:grocerlytics/features/receipt/review_receipt/data/create_receipt_local_service.dart';
import 'package:grocerlytics/features/receipt/review_receipt/data/create_receipt_request.dart';
import 'package:grocerlytics/features/receipt/review_receipt/data/create_receipt_service.dart';
import 'package:grocerlytics/features/receipt/review_receipt/models/create_receipt_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class CreateReceiptUseCase {
  const CreateReceiptUseCase({
    required this.createReceiptService,
    required this.createReceiptLocalService,
  });

  final CreateReceiptService createReceiptService;
  final CreateReceiptLocalService createReceiptLocalService;

  Future<void> run(CreateReceiptModel model) async {
    final receivePort = ReceivePort();

    await Isolate.spawn(
      (Map<String, dynamic> message) {
        final SendPort sendPort = message['sendPort'];
        final data = _processReceiptData(message);
        sendPort.send(data);
      },
      {
        'sendPort': receivePort.sendPort,
        'model': model,
      },
    );

    final data = await receivePort.first as CreateReceiptRequestModel;

    if (model.userId.isNotEmpty) {
      createReceiptService.run(data.toJson);
    }

    return createReceiptLocalService.run(
      receiptId: data.id,
      userId: data.userId,
      currencyId: data.currencyId,
      totalAmount: data.totalAmount,
      storeName: data.storeName,
      purchaseDate: data.purchaseDate,
      items: data.items.map((e) => e.toJson).toList(),
    );
  }

  static CreateReceiptRequestModel _processReceiptData(
      Map<String, dynamic> message) {
    final model = message['model'] as CreateReceiptModel;
    final receiptId = const Uuid().v4();

    return CreateReceiptRequestModel(
      id: receiptId,
      userId: model.userId,
      currencyId: model.currencyId,
      storeName: model.storeName,
      totalAmount: model.totalAmount,
      purchaseDate: model.purchaseDate,
      items: model.items
          .map(
            (e) => CreateReceiptItemRequestModel(
              id: const Uuid().v4(),
              receiptId: receiptId,
              itemName: e.itemName,
              itemAbrv: e.itemAbrv,
              price: e.price,
              quantity: e.quantity,
              quantityUnitId: e.quantityUnitId,
              categoryId: e.categoryId,
            ),
          )
          .toList(),
    );
  }
}
