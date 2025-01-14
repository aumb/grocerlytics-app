import 'dart:convert';

import 'package:grocerlytics/features/common/models/session/session_response_model.dart';
import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyOtpSignInService {
  const VerifyOtpSignInService(
    this.service,
  );

  final NetworkService service;

  Future<SessionResponseModel> run(String email, String otp) async {
    final result = await service.post(
      '${NetworkModule.auth.path}/verify-otp',
      data: {
        'email': email,
        'token': otp,
      },
      requiresAuth: false,
    );
    final decodedResult = jsonDecode(result.data);

    return SessionResponseModel.fromJson(decodedResult ?? {});
  }
}
