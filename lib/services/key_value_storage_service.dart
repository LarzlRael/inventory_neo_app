abstract class KeyValueStorageService {
  Future<void> setKeyValue<T>(String key, String value);
  Future<T?> getValue<T>(String key, String value);
  Future<bool> removeKey(String key);
}
