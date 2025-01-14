import 'package:grocerlytics/features/common/local_storage/local_storage.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage_keys.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserIdUseCase {
  const GetUserIdUseCase({
    required this.localStorage,
  });

  final LocalStorage localStorage;

  String run() => localStorage.getValue(LocalStorageKeys.userId);
}
