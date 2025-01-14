import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/auth/logout/domain/logout_use_case.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/settings/ui/settings_page.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit({
    required this.logoutUseCase,
  }) : super(LogoutState.initial());

  final LogoutUseCase logoutUseCase;

  Future<void> logout() async {
    buttonClickTracking(
      page: '$SettingsPage',
      buttonInfo: 'Logging out',
    );
    emit(state.copyWith(status: const LoadingStatus()));
    await logoutUseCase.run();
    emit(state.copyWith(status: const LoadedStatus()));
  }
}

class LogoutState extends Equatable {
  const LogoutState._({
    required this.status,
  });

  factory LogoutState.initial() => const LogoutState._(
        status: InitialStatus(),
      );

  final Status<LogoutState> status;

  LogoutState copyWith({
    Status<LogoutState>? status,
  }) =>
      LogoutState._(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status];
}
