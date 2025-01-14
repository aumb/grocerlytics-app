import 'dart:async';
import 'dart:developer';

import 'package:grocerlytics/features/common/local_storage/local_storage.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage_keys.dart';
import 'package:grocerlytics/features/common/services/refresh_token/refresh_token_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RefreshTokenUseCase {
  RefreshTokenUseCase({
    required this.localStorage,
    required this.refreshTokenService,
  });

  final LocalStorage localStorage;
  final RefreshTokenService refreshTokenService;

  Completer<void>? _refreshTokenCompleter;

  Future<void> run() async {
    if (_refreshTokenCompleter != null) {
      return _refreshTokenCompleter!.future;
    }

    _refreshTokenCompleter = Completer<void>();

    try {
      final refreshToken = localStorage.getValue(LocalStorageKeys.refreshToken);
      final response = await refreshTokenService.run(refreshToken);

      await localStorage.setValue(
        LocalStorageKeys.accessToken,
        response.accessToken,
      );
      await localStorage.setValue(
        LocalStorageKeys.refreshToken,
        response.refreshToken,
      );

      _refreshTokenCompleter!.complete();
    } catch (e) {
      log(e.toString());
      _refreshTokenCompleter!.completeError(e);
      await Future.wait([
        localStorage.removeValue(LocalStorageKeys.accessToken),
        localStorage.removeValue(LocalStorageKeys.refreshToken),
        localStorage.removeValue(LocalStorageKeys.userId),
      ]);
    } finally {
      _refreshTokenCompleter = null;
    }
  }
}
