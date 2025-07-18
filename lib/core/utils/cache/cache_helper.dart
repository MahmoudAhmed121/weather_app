import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() async {
    return await sharedPreferences.clear();
  }

  static Future<bool> putBool({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static String getString({
    required String key,
  }) {
    return sharedPreferences.getString(key) ?? '';
  }

  static int getInteger({
    required String key,
  }) {
    return sharedPreferences.getInt(key) ?? 0;
  }

  static bool getBool({required String key}) {
    return sharedPreferences.getBool(key) ?? false;
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }

  static Future<void> setSecureStorage({
    required String key,
    required String value,
  }) async {
    try {
      const flutterSecureStorage = FlutterSecureStorage(
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      );
      await flutterSecureStorage.write(key: key, value: value);
    } catch (e, stackTrace) {
      return;
     
    }
  }

  static Future<String> getSecureStorage({
    required String key,
  }) async {
    try {
      const flutterSecureStorage = FlutterSecureStorage(
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      );
      final value = await flutterSecureStorage.read(key: key);

      return value ?? '';
    } catch (e, stackTrace) {
      return '';
    }
  }

  static Future<void> deleteSecureStorage({
    required String key,
  }) async {
    try {
      const flutterSecureStorage = FlutterSecureStorage(
        iOptions: IOSOptions(
          
          accessibility: KeychainAccessibility.first_unlock,
        ),
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      );

      await flutterSecureStorage.delete(key: key);
    } catch (e, stackTrace) {
      return;
    }
  }
}
