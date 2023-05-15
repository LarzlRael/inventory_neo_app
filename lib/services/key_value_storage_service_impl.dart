import 'package:inventory_app/services/key_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageServiceImpl implements KeyValueStorageService {
  Future<SharedPreferences> getSharedPref() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key, String value) async {
    final prefs = getSharedPref();
    switch (T) {
      case int:
        return (await prefs).getInt(key) as T?;

      case String:
        return (await prefs).getString(key) as T?;

      case bool:
        return (await prefs).getBool(key) as T?;

      default:
        throw Exception('Type not found');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = getSharedPref();
    return (await prefs).remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, String value) async {
    final prefs = getSharedPref();
    switch (T) {
      case int:
        await (await prefs).setInt(key, value as int);
        break;
      case String:
        await (await prefs).setString(key, value);
        break;
      case bool:
        await (await prefs).setBool(key, value as bool);
        break;
      default:
    }
  }
}
