import 'package:equatable/equatable.dart';
import 'package:grocerlytics/features/auth/models/user.dart';

class SessionResponseModel extends Equatable {
  const SessionResponseModel._({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.expiresAt,
    required this.user,
  });

  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final int expiresAt;
  final User user;

  factory SessionResponseModel.fromJson(Map<String, dynamic> json) =>
      SessionResponseModel._(
        accessToken: json['access_token'] as String,
        refreshToken: json['refresh_token'] as String,
        tokenType: json['token_type'] as String,
        expiresIn: json['expires_in'] as int,
        expiresAt: json['expires_at'] as int,
        user: User.fromJson(json['user']),
      );

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        tokenType,
        expiresIn,
        expiresAt,
        user,
      ];
}
