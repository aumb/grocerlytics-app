import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/currencies/domain/get_currencies_use_case.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:injectable/injectable.dart';

@injectable
class CurrenciesCubit extends Cubit<CurrenciesState> {
  CurrenciesCubit({
    required this.getCurrenciesUseCase,
  }) : super(CurrenciesState.initial());

  final GetCurrenciesUseCase getCurrenciesUseCase;

  Future<void> init() async {
    emit(
      state.copyWith(
        status: const LoadingStatus(),
      ),
    );
    try {
      final result = await getCurrenciesUseCase.run();

      emit(
        state.copyWith(
          status: const LoadedStatus(),
          selectedCurrency: result.first,
          currencies: result,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: ErrorStatus(e),
        ),
      );
      rethrow;
    }
  }
}

class CurrenciesState extends Equatable {
  const CurrenciesState._({
    required this.status,
    required this.currencies,
    required this.selectedCurrency,
  });

  final Status<CurrenciesState> status;
  final List<CurrencyModel> currencies;
  final CurrencyModel selectedCurrency;

  factory CurrenciesState.initial() {
    return const CurrenciesState._(
      status: LoadingStatus(),
      currencies: [],
      selectedCurrency: CurrencyModel(
        id: 1,
        name: 'United States Dollar',
        code: '',
        symbol: '',
      ),
    );
  }

  CurrenciesState copyWith({
    List<CurrencyModel>? currencies,
    Status<CurrenciesState>? status,
    CurrencyModel? selectedCurrency,
  }) {
    return CurrenciesState._(
      status: status ?? this.status,
      currencies: currencies ?? this.currencies,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
    );
  }

  @override
  List<Object?> get props => [
        currencies,
        status,
        selectedCurrency,
      ];
}
