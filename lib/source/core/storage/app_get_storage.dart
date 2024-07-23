import 'package:get_storage/get_storage.dart';

abstract class AppGetStorage {
  static final _getStorage = GetStorage();

  //region keys
  //endregions keys

  ///region Functions
  static T read<T>(String key, T defaultValue) =>
      _getStorage.read<T>(key) ?? defaultValue;

  static Future<void> write(String key, dynamic value) =>
      _getStorage.write(key, value);

  static Future<void> remove(String key) => _getStorage.remove(key);

  static Future<void> removeAll() => _getStorage.erase();

  ///endregion
}
