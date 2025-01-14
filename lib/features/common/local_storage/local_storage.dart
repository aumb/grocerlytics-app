import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class LocalStorage {
  const LocalStorage({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  String getValue(String key) => sharedPreferences.getString(key) ?? '';

  List<String> getListValue(String key) =>
      sharedPreferences.getStringList(key) ?? [];

  Future<void> setValue(String key, String value) =>
      sharedPreferences.setString(key, value);
  Future<void> setListValue(String key, List<String> value) =>
      sharedPreferences.setStringList(key, value);

  Future<void> removeValue(
    String key,
  ) =>
      sharedPreferences.remove(key);
}
