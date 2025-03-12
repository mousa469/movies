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
  static const String lastMoviesList = "lastMoviesList";

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setString(
      {required String key, required String value}) async {
    await sharedPreferences.setString(key, value);
  }

  static Future<String?> getString({required String key}) async {
    return sharedPreferences.getString(key);
  }

  static Future<void> setBool(
      {required String key, required bool value}) async {
    await sharedPreferences.setBool(key, value);
  }

  static Future<bool?> getBool({required String key}) async {
    return sharedPreferences.getBool(key);
  }

  static Future<void> setDouble(
      {required String key, required double value}) async {
    await sharedPreferences.setDouble(key, value);
  }

  static Future<double?> getDouble({required String key}) async {
    return sharedPreferences.getDouble(key);
  }

  static Future<void> setInt({required String key, required int value}) async {
    await sharedPreferences.setInt(key, value);
  }

  static Future<int?> getInt({required String key}) async {
    return sharedPreferences.getInt(key);
  }

  static void markUserIsLogined() {
    SharedPrefs.setBool(key: isLoginedBefore, value: true);
  }

  static void storeUserInfoInLocalStorage({required UserModel userModel}) {
    SharedPrefs.setString(key: userEmail, value: userModel.email);
    SharedPrefs.setString(key: userID, value: userModel.uid!);
    SharedPrefs.setString(key: userName, value: userModel.name);
  }

  static void markUserIsRegistered() {
    SharedPrefs.setBool(key: isRegisteredBefore, value: true);
  }

 


}
