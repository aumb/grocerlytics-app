import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/categories/models/category_model.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/quantity_units/models/quantity_unit_model.dart';
import 'package:grocerlytics/features/spending/spending_category/domain/get_spending_category_use_case.dart';
import 'package:grocerlytics/features/spending/spending_category/models/spending_category_transaction_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class SpendingCategoryCubit extends Cubit<SpendingCategoryState> {
  SpendingCategoryCubit({
    required this.spendingCategoryUseCase,
  }) : super(SpendingCategoryState.initial());

  final GetSpendingCategoryUseCase spendingCategoryUseCase;

  SpendingCategoryTransactionModel get placeholderModel =>
      SpendingCategoryTransactionModel(
        id: '',
        storeName: '',
        itemName: '',
        quantityModel: const QuantityModel(
          quantity: 0,
          quantityUnitModel: QuantityUnitModel(
            id: 0,
            shorthand: '',
            name: '',
          ),
        ),
        priceModel: const PriceModel(
          price: 0,
          currencyModel: CurrencyModel(id: 0, name: '', code: '', symbol: ''),
        ),
        purchaseDate: DateTime.now(),
      );

  Future<void> init(
    CategoryModel model,
    String userId,
    String startDate,
    String endDate,
    List<QuantityUnitModel> quantityUnits,
    List<CurrencyModel> currencies,
    int count,
  ) async {
    if (count < 1) {
      emit(
        state.copyWith(
          count: count,
          categoryModel: model,
          status: const EmptyStatus(),
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        count: count,
        categoryModel: model,
        status: const LoadingStatus(),
        transactions: List.generate(
          count,
          (_) => placeholderModel,
        ),
      ),
    );

    try {
      final result = await spendingCategoryUseCase.run(
        userId,
        model.id,
        startDate,
        endDate,
        quantityUnits,
        currencies,
      );

      emit(
        state.copyWith(
          status: const LoadedStatus(),
          transactions: result,
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

class SpendingCategoryState extends Equatable {
  const SpendingCategoryState._({
    required this.status,
    required this.categoryModel,
    required this.transactions,
    required this.count,
  });

  final Status<SpendingCategoryState> status;
  final CategoryModel categoryModel;
  final List<SpendingCategoryTransactionModel> transactions;
  final int count;

  factory SpendingCategoryState.initial() {
    return const SpendingCategoryState._(
      status: LoadingStatus(),
      count: 0,
      categoryModel: CategoryModel(
        id: 0,
        label: '',
        color: Colors.purple,
        iconData: Icons.shopping_cart,
      ),
      transactions: [],
    );
  }

  SpendingCategoryState copyWith({
    CategoryModel? categoryModel,
    Status<SpendingCategoryState>? status,
    List<SpendingCategoryTransactionModel>? transactions,
    int? count,
  }) {
    return SpendingCategoryState._(
      status: status ?? this.status,
      categoryModel: categoryModel ?? this.categoryModel,
      transactions: transactions ?? this.transactions,
      count: count ?? this.count,
    );
  }

  @override
  List<Object?> get props => [status, categoryModel, transactions];
}
