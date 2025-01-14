import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:grocerlytics/features/common/local_storage/local_database.dart';
import 'package:grocerlytics/features/common/models/app_info.dart';
import 'package:injectable/injectable.dart';
import 'package:plausible_analytics/plausible_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  final pubspec = await rootBundle.loadString("pubspec.yaml");
  final versionBuild = pubspec.split("\nversion:")[1].split("\n")[0].trim();

  const plausibleServerUrl = String.fromEnvironment('PLAUSIBLE_SERVER_URL');
  const plausibleDomain = String.fromEnvironment('PLAUSIBLE_DOMAIN');

  final sharedPreferences = await SharedPreferences.getInstance();
  final localDb = await LocalDatabase.initDatabase;
  final localStorageService = LocalDatabase(database: localDb);

  getIt
      .registerLazySingleton<AppInfo>(() => AppInfo(buildNumber: versionBuild));
  getIt.registerLazySingleton<Plausible>(
      () => Plausible(plausibleServerUrl, plausibleDomain));
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<LocalDatabase>(() => localStorageService);
  getIt.registerLazySingleton<Dio>((() => Dio()));

  getIt.init();
}
