import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/local_storage/local_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSavedThemeUseCase {
  const GetSavedThemeUseCase({
    required this.localStorage,
  });

  final LocalStorage localStorage;

  ThemeMode run() => ThemeMode.values.firstWhere(
        (e) => e.name == localStorage.getValue('theme'),
        orElse: () => ThemeMode.system,
      );
}
