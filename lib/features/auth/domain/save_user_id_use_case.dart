import 'package:grocerlytics/features/common/local_storage/local_storage.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage_keys.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveUserIdUseCase {
  const SaveUserIdUseCase({
    required this.localStorage,
  });

  final LocalStorage localStorage;

  Future<void> run(String userId) =>
      localStorage.setValue(LocalStorageKeys.userId, userId);
}
