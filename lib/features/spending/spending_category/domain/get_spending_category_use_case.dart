import 'dart:isolate';

import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/quantity_units/models/quantity_unit_model.dart';
import 'package:grocerlytics/features/spending/spending_category/data/spending_category_local_service.dart';
import 'package:grocerlytics/features/spending/spending_category/data/spending_category_response.dart';
import 'package:grocerlytics/features/spending/spending_category/models/spending_category_transaction_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSpendingCategoryUseCase {
  const GetSpendingCategoryUseCase({
    required this.spendingCategoryLocalService,
  });

  final SpendingCategoryLocalService spendingCategoryLocalService;

  Future<List<SpendingCategoryTransactionModel>> run(
    String userId,
    int categoryId,
    String startDate,
    String endDate,
    List<QuantityUnitModel> quantityUnits,
    List<CurrencyModel> currencies,
  ) async {
    final result = await spendingCategoryLocalService.run(
        userId, categoryId, startDate, endDate);

    final receivePort = ReceivePort();
    await Isolate.spawn(
      (Map<String, dynamic> message) {
        final SendPort sendPort = message['sendPort'];
        final data = message['data'];
        final transactions = _processTransactions(data);
        sendPort.send(transactions);
      },
      {
        'sendPort': receivePort.sendPort,
        'data': {
          'result': result,
          'quantityUnits': quantityUnits,
          'currencies': currencies,
        },
      },
    );

    final transactions =
        await receivePort.first as List<SpendingCategoryTransactionModel>;

    return transactions;
  }

  static List<SpendingCategoryTransactionModel> _processTransactions(
      Map<String, dynamic> data) {
    final result = data['result'] as SpendingCategoryItemsResponse;
    final quantityUnits = data['quantityUnits'] as List<QuantityUnitModel>;
    final currencies = data['currencies'] as List<CurrencyModel>;

    final items = <SpendingCategoryTransactionModel>[];

    for (final categoryItem in result.categoryItems) {
      for (final item in categoryItem.items) {
        items.add(
          SpendingCategoryTransactionModel(
            id: item.id,
            storeName: categoryItem.receipt.storeName,
            itemName: item.itemName,
            quantityModel: QuantityModel(
              quantity: item.quantity,
              quantityUnitModel: quantityUnits.firstWhere(
                (e) => e.id == item.quantityUnitId,
              ),
            ),
            priceModel: PriceModel(
              price: item.price,
              currencyModel: currencies.firstWhere(
                (e) => e.id == categoryItem.receipt.currencyId,
              ),
            ),
            purchaseDate: categoryItem.receipt.purchaseDate,
          ),
        );
      }
    }
    return items;
  }
}
