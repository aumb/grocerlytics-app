import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/quantity_units/domain/get_quantity_units_use_case.dart';
import 'package:grocerlytics/features/common/quantity_units/models/quantity_unit_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class QuantityUnitsCubit extends Cubit<QuantityUnitsState> {
  QuantityUnitsCubit({
    required this.getQuantityUnitsUseCase,
  }) : super(QuantityUnitsState.initial());

  final GetQuantityUnitsUseCase getQuantityUnitsUseCase;

  Future<void> init() async {
    emit(
      state.copyWith(
        status: const LoadingStatus(),
      ),
    );
    try {
      final result = await getQuantityUnitsUseCase.run();

      emit(
        state.copyWith(
          status: const LoadedStatus(),
          fallbackQuantity: result.first,
          quantities: result,
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

class QuantityUnitsState extends Equatable {
  const QuantityUnitsState._({
    required this.status,
    required this.quantities,
    required this.fallbackQuantity,
  });

  final Status<QuantityUnitsState> status;
  final List<QuantityUnitModel> quantities;
  final QuantityUnitModel fallbackQuantity;

  factory QuantityUnitsState.initial() {
    return const QuantityUnitsState._(
      status: LoadingStatus(),
      quantities: [],
      fallbackQuantity: QuantityUnitModel(
        id: 0,
        shorthand: 'wwww',
        name: 'wwwww',
      ),
    );
  }

  QuantityUnitsState copyWith({
    List<QuantityUnitModel>? quantities,
    Status<QuantityUnitsState>? status,
    QuantityUnitModel? fallbackQuantity,
  }) {
    return QuantityUnitsState._(
      status: status ?? this.status,
      quantities: quantities ?? this.quantities,
      fallbackQuantity: fallbackQuantity ?? this.fallbackQuantity,
    );
  }

  @override
  List<Object?> get props => [
        quantities,
        status,
        fallbackQuantity,
      ];
}
