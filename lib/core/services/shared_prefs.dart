import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences sharedPreferences;
  static const String isOnBoardingSeenBefore = "isOnBoardingSeenBefore";

  /// Initialize SharedPreferences once

  /// ✅ Add an async initialization method
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    return sharedPreferences.getString(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    return sharedPreferences.getBool(key);
  }

  static Future<void> setDouble(String key, double value) async {
    await sharedPreferences.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    return sharedPreferences.getDouble(key);
  }

  static Future<void> setInt(String key, int value) async {
    await sharedPreferences.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    return sharedPreferences.getInt(key);
  }
}
