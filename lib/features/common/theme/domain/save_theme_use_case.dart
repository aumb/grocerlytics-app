import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage_keys.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveThemeUseCase {
  const SaveThemeUseCase({
    required this.localStorage,
  });

  final LocalStorage localStorage;

  Future<void> run(ThemeMode mode) =>
      localStorage.setValue(LocalStorageKeys.theme, mode.name);
}
