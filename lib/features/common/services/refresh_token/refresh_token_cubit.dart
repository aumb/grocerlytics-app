import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/services/refresh_token/refresh_token_use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RefreshTokenCubit extends Cubit<RefreshTokenState> {
  RefreshTokenCubit({
    required this.refreshTokenUseCase,
  }) : super(RefreshTokenState.initial());

  final RefreshTokenUseCase refreshTokenUseCase;

  Future<void> refreshToken() async {
    emit(state.copyWith(status: const LoadingStatus()));
    await refreshTokenUseCase.run();
    emit(state.copyWith(status: const LoadedStatus()));
  }

  void handleRefreshError() {
    emit(state.copyWith(status: const ErrorStatus('')));
  }
}

class RefreshTokenState extends Equatable {
  const RefreshTokenState._({
    required this.status,
  });

  factory RefreshTokenState.initial() => const RefreshTokenState._(
        status: InitialStatus(),
      );

  final Status<RefreshTokenState> status;

  RefreshTokenState copyWith({
    Status<RefreshTokenState>? status,
  }) =>
      RefreshTokenState._(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status];
}
