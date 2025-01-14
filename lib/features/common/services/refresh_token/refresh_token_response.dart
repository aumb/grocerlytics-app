import 'package:equatable/equatable.dart';

class RefreshTokenResponse extends Equatable {
  const RefreshTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
