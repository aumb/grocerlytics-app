import 'dart:convert';

import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:grocerlytics/features/common/services/refresh_token/refresh_token_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RefreshTokenService {
  const RefreshTokenService({
    required this.networkService,
  });

  final NetworkService networkService;

  Future<RefreshTokenResponse> run(String refreshToken) async {
    final result = await networkService.post(
      '${NetworkModule.auth.path}/refresh-token',
      data: {
        'refresh_token': refreshToken,
      },
    );

    final decodedResponse = jsonDecode(result.data);

    return RefreshTokenResponse.fromJson(decodedResponse);
  }
}
