import 'package:grocerlytics/features/common/local_storage/local_storage.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage_keys.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveAccessTokenUseCase {
  const SaveAccessTokenUseCase({
    required this.localStorage,
  });

  final LocalStorage localStorage;

  Future<void> run(String accessToken) =>
      localStorage.setValue(LocalStorageKeys.accessToken, accessToken);
}
