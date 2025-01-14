import 'package:grocerlytics/features/common/local_storage/local_storage.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage_keys.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveRefreshTokenUseCase {
  const SaveRefreshTokenUseCase({
    required this.localStorage,
  });

  final LocalStorage localStorage;

  Future<void> run(String refreshToken) =>
      localStorage.setValue(LocalStorageKeys.refreshToken, refreshToken);
}
