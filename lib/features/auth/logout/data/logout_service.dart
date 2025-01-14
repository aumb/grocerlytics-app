import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutService {
  const LogoutService(
    this.service,
  );

  final NetworkService service;

  Future<void> run() => service.post(
        '${NetworkModule.auth.path}/sign-out',
        requiresAuth: true,
      );
}
