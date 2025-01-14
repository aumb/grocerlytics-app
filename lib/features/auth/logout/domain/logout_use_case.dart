import 'dart:async';

import 'package:grocerlytics/features/auth/logout/data/logout_service.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage_keys.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase {
  const LogoutUseCase({
    required this.logoutService,
    required this.localStorage,
  });

  final LocalStorage localStorage;
  final LogoutService logoutService;

  Future<void> run() async {
    await logoutService.run();
    await Future.wait([
      localStorage.removeValue(LocalStorageKeys.accessToken),
      localStorage.removeValue(LocalStorageKeys.refreshToken),
      localStorage.removeValue(LocalStorageKeys.userId),
    ]);
  }
}
