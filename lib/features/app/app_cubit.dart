import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState.initial());

  Future<void> init(
    Future<void> Function() initCurrencies,
    Future<void> Function() initQuantities,
    Future<void> Function() initCategories,
    Future<void> Function() getUser,
    Future<void> Function() syncWithServer,
  ) async {
    emit(
      state.copyWith(
        status: const LoadingStatus(),
      ),
    );
    try {
      await Future.wait([
        initCurrencies(),
        initQuantities(),
        initCategories(),
        getUser(),
      ]);

      await syncWithServer();

      emit(
        state.copyWith(
          status: const LoadedStatus(),
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

class AppState extends Equatable {
  const AppState._({
    required this.status,
  });

  final Status<AppState> status;

  factory AppState.initial() {
    return const AppState._(
      status: LoadingStatus(),
    );
  }

  AppState copyWith({
    Status<AppState>? status,
  }) {
    return AppState._(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
