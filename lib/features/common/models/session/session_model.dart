import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/auth/models/user.dart';
import 'package:grocerlytics/features/common/models/session/session_response_model.dart';

class SessionModel extends Equatable {
  const SessionModel._({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory SessionModel.fromResponse(SessionResponseModel response) =>
      SessionModel._(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        user: response.user,
      );

  final String accessToken;
  final String refreshToken;
  final User user;

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        user,
      ];
}
