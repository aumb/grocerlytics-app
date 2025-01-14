import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/auth/domain/save_access_token_use_case.dart';
import 'package:grocerlytics/features/auth/domain/save_refresh_token_use_case.dart';
import 'package:grocerlytics/features/auth/domain/save_user_id_use_case.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/sign_in/verify_otp_sign_in/domain/verify_otp_sign_in_use_case.dart';
import 'package:grocerlytics/features/sign_in/verify_otp_sign_in/ui/verify_otp_sign_in_page.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyOtpSignInCubit extends Cubit<VerifyOtpSignInState> {
  VerifyOtpSignInCubit({
    required this.verifyOtpSignInUseCase,
    required this.saveAccessTokenCase,
    required this.saveRefreshTokenCase,
    required this.saveUserIdUseCase,
  }) : super(VerifyOtpSignInState.initial());

  final VerifyOtpSignInUseCase verifyOtpSignInUseCase;
  final SaveAccessTokenUseCase saveAccessTokenCase;
  final SaveRefreshTokenUseCase saveRefreshTokenCase;
  final SaveUserIdUseCase saveUserIdUseCase;

  void onOtpChanged(String? value) => emit(
        state.copyWith(
          otp: value,
          status: const InitialStatus(),
        ),
      );

  Future<void> submit(String email) async {
    buttonClickTracking(
      page: '$VerifyOtpSignInPage',
      buttonInfo: 'Submitting OTP',
    );
    emit(
      state.copyWith(
        status: const LoadingStatus(),
      ),
    );
    try {
      final result = await verifyOtpSignInUseCase.run(email, state.otp);

      await Future.wait([
        saveAccessTokenCase.run(result.accessToken),
        saveRefreshTokenCase.run(result.refreshToken),
        saveUserIdUseCase.run(result.user.id),
      ]);

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

class VerifyOtpSignInState extends Equatable {
  const VerifyOtpSignInState._({
    required this.status,
    required this.otp,
  });

  final Status<VerifyOtpSignInState> status;
  final String otp;

  factory VerifyOtpSignInState.initial() {
    return const VerifyOtpSignInState._(
      status: InitialStatus(),
      otp: '',
    );
  }

  VerifyOtpSignInState copyWith({
    Status<VerifyOtpSignInState>? status,
    String? otp,
  }) {
    return VerifyOtpSignInState._(
      status: status ?? this.status,
      otp: otp ?? this.otp,
    );
  }

  @override
  List<Object?> get props => [status, otp];
}
