import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/receipt_details/domain/get_unassigned_receipts_details_use_case.dart';
import 'package:grocerlytics/features/sign_in/domain/sign_in_use_case.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/sign_in/ui/sign_in_page.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.signInUseCase,
    required this.getUnassignedReceiptsDetailsUseCase,
  }) : super(SignInState.initial());

  final SignInUseCase signInUseCase;
  final GetUnassignedReceiptsDetailsUseCase getUnassignedReceiptsDetailsUseCase;

  void onEmailChanged(String? value) => emit(
        state.copyWith(
          email: value,
          status: const InitialStatus(),
        ),
      );

  Future<void> signIn() async {
    buttonClickTracking(
      page: '$SignInPage',
      buttonInfo: 'Submitting log in',
    );
    emit(
      state.copyWith(
        status: const LoadingStatus(),
      ),
    );
    try {
      await signInUseCase.run(state.email);
      await getUnassignedReceiptsDetailsUseCase.run();

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

class SignInState extends Equatable {
  const SignInState._({
    required this.status,
    required this.email,
  });

  final Status<SignInState> status;
  final String email;

  factory SignInState.initial() {
    return const SignInState._(
      status: InitialStatus(),
      email: '',
    );
  }

  SignInState copyWith({
    Status<SignInState>? status,
    String? email,
  }) {
    return SignInState._(
      status: status ?? this.status,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [status, email];
}
