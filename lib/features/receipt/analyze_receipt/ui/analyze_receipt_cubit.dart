import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/categories/models/category_model.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/quantity_units/models/quantity_unit_model.dart';
import 'package:grocerlytics/features/receipt/analyze_receipt/domain/analyze_receipt_use_case.dart';
import 'package:grocerlytics/features/receipt/models/receipt_item_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class AnalyzeReceiptCubit extends Cubit<AnalyzeReceiptState> {
  AnalyzeReceiptCubit({
    required this.analyzeReceiptUseCase,
  }) : super(AnalyzeReceiptState.initial());

  final AnalyzeReceiptUseCase analyzeReceiptUseCase;

  Future<void> init(
    XFile file,
    CurrencyModel selectedCurrency,
    List<QuantityUnitModel> quantityUnits,
    List<CategoryModel> categories,
  ) async {
    emit(
      state.copyWith(
        status: const LoadingStatus(),
      ),
    );
    try {
      final result = await analyzeReceiptUseCase.run(file);

      final items = result.items
          .map((e) => ReceiptItemModel(
                id: const Uuid().v4(),
                name: e.itemName,
                itemAbrv: e.itemAbrv,
                categoryModel:
                    categories.firstWhere((c) => c.id == e.categoryId),
                priceModel: ReceiptItemPriceModel(
                  price: e.price,
                  unit: selectedCurrency,
                ),
                quantityModel: ReceiptItemQuantityModel(
                  quantity: e.quantity,
                  unit:
                      quantityUnits.firstWhere((q) => q.id == e.quantityUnitId),
                ),
              ))
          .toList();

      emit(
        state.copyWith(
          status: const LoadedStatus(),
          storeName: result.storeName,
          items: items,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: ErrorStatus(e),
        ),
      );
    }
  }
}

class AnalyzeReceiptState extends Equatable {
  const AnalyzeReceiptState._({
    required this.status,
    required this.storeName,
    required this.items,
  });

  final Status<AnalyzeReceiptState> status;
  final String storeName;

  final List<ReceiptItemModel> items;

  factory AnalyzeReceiptState.initial() {
    return const AnalyzeReceiptState._(
      status: LoadingStatus(),
      storeName: '',
      items: [],
    );
  }

  AnalyzeReceiptState copyWith({
    Status<AnalyzeReceiptState>? status,
    String? storeName,
    DateTime? purchaseDate,
    List<ReceiptItemModel>? items,
  }) {
    return AnalyzeReceiptState._(
      status: status ?? this.status,
      storeName: storeName ?? this.storeName,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [status, storeName, items];
}
