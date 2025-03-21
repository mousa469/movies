import 'dart:convert';

import 'package:movies/features/authentication/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences sharedPreferences;
  static const String isOnBoardingSeenBefore = "isOnBoardingSeenBefore";
  static const String isRegisteredBefore = "isRegisteredBefore";
  static const String userEmail = "userEmail";
  static const String userName = "userName";
  static const String userID = "userID";
  static const String isLoginedBefore = "isLoginedBefore";
  static const String lastAvailableMoviesList = "lastMoviesList";
  static const String lastWatchNowMoviesList = "lastMoviesList";
  static const String wishList = "wishList";
  static const String history = "history";

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setString(
      {required String key, required String value}) async {
    await sharedPreferences.setString(key, value);
  }

  static String? getString({required String key}) {
    return sharedPreferences.getString(key);
  }

  static Future<void> setBool(
      {required String key, required bool value}) async {
    await sharedPreferences.setBool(key, value);
  }

  static bool? getBool({required String key}) {
    return sharedPreferences.getBool(key);
  }

  static Future<void> setDouble(
      {required String key, required double value}) async {
    await sharedPreferences.setDouble(key, value);
  }

  static double? getDouble({required String key}) {
    return sharedPreferences.getDouble(key);
  }

  static Future<void> setInt({required String key, required int value}) async {
    await sharedPreferences.setInt(key, value);
  }

  static int? getInt({required String key}) {
    return sharedPreferences.getInt(key);
  }

  static void setList({required String key, required List<String> value}) {
    sharedPreferences.setStringList(key, value);
  }

  static List<String>? getList({required String key}) {
    return sharedPreferences.getStringList(key);
  }

  static void markUserIsLogined() {
    SharedPrefs.setBool(key: isLoginedBefore, value: true);
  }

  static void storeUserInfoInLocalStorage(
      {required String email, required String name, required String uid}) {
    SharedPrefs.setString(key: userEmail, value: email);
    SharedPrefs.setString(key: userID, value: uid);
    SharedPrefs.setString(key: userName, value: name);
    markUserIsRegistered();
  }

  static void markUserIsRegistered() {
    SharedPrefs.setBool(key: isRegisteredBefore, value: true);
  }
}
