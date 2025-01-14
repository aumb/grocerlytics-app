import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInService {
  const SignInService(
    this.service,
  );

  final NetworkService service;

  Future<void> run(String email) => service.post(
        '${NetworkModule.auth.path}/signin-otp',
        data: {
          'email': email,
        },
        requiresAuth: false,
      );
}
