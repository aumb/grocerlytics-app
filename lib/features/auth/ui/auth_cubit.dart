import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/auth/domain/get_access_token_use_case.dart';
import 'package:grocerlytics/features/auth/domain/get_user_use_case.dart';
import 'package:grocerlytics/features/auth/logout/domain/logout_use_case.dart';
import 'package:grocerlytics/features/auth/models/user.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.getUserUseCase,
    required this.logoutUseCase,
    required this.getAccessTokenUseCase,
  }) : super(AuthState.initial());

  final GetUserUseCase getUserUseCase;
  final GetAccessTokenUseCase getAccessTokenUseCase;
  final LogoutUseCase logoutUseCase;

  String get _accessToken => getAccessTokenUseCase.run();

  Future<void> fetchUser() async {
    if (_accessToken.isNotEmpty) {
      emit(state.copyWith(status: const LoadingStatus()));

      try {
        final result = await getUserUseCase.run();

        emit(
          state.copyWith(
            status: const LoadedStatus(),
            user: result,
          ),
        );
      } catch (e) {
        log(e.toString());
        emit(
          state.copyWith(
            status: const InitialStatus(),
          ),
        );
        rethrow;
      }
    }
  }

  void resetAuth() {
    emit(AuthState.initial());
  }
}

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    required this.user,
  });

  factory AuthState.initial() => AuthState._(
      status: const InitialStatus(),
      user: User(
        id: '',
        aud: '',
        role: '',
        email: '',
        phone: '',
        appMetadata: {},
        userMetadata: {},
        identities: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

  final Status<AuthState> status;
  final User user;

  bool get isNotLoggedIn => user.id.isEmpty;

  AuthState copyWith({
    Status<AuthState>? status,
    User? user,
  }) =>
      AuthState._(
        status: status ?? this.status,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [status, user];
}
