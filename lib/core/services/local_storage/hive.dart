import 'package:hive_flutter/hive_flutter.dart';

import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/profile/data/models/user_profile_model.dart';

class HiveStorage extends LocalStorage {
  static late Box hiveBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(MovieModelAdapter());
    Hive.registerAdapter(MovieEntityAdapter());
      Hive.registerAdapter(UserProfileModelAdapter());


    hiveBox = await Hive.openBox('storageBox');
  }

  @override
  Future<void> setString({required String key, required String value}) async {
    await hiveBox.put(key, value);
  }

  @override
  String? getString({required String key}) {
    return hiveBox.get(key);
  }

  @override
  Future<void> setBool({required String key, required bool value}) async {
    await hiveBox.put(key, value);
  }

  @override
  bool? getBool({required String key}) {
    return hiveBox.get(key);
  }

  @override
  Future<void> setDouble({required String key, required double value}) async {
    await hiveBox.put(key, value);
  }

  @override
  double? getDouble({required String key}) {
    return hiveBox.get(key);
  }

  @override
  Future<void> setInt({required String key, required int value}) async {
    await hiveBox.put(key, value);
  }

  @override
  int? getInt({required String key}) {
    return hiveBox.get(key);
  }

  @override
  Future<void> setList<T>({required String key, required List<T> value}) async {
    await hiveBox.put(key, value);
  }

  @override
  List<T>? getList<T>({required String key}) {
    return hiveBox.get(key)?.cast<T>();
  }

  @override
  void markUserIsLogined() {
    setBool(key: LocalStorage.isLoginedBefore, value: true);
  }

  @override
  void storeUserInfoInLocalStorage(
      {required String email, required String name, required String uid ,required String phone,required String signInMethode}) {
    setString(key: LocalStorage.userEmail, value: email);
    setString(key: LocalStorage.userID, value: uid);
    setString(key: LocalStorage.userName, value: name);
    setString(key: LocalStorage.userPhone, value: phone);
    setString(key: LocalStorage.signInMethode, value: signInMethode);
    markUserIsRegistered();
  }

  @override
  void markUserIsRegistered() {
    setBool(key: LocalStorage.isRegisteredBefore, value: true);
  }

  @override
  Future<void> clearData({required String key}) async {
    await hiveBox.delete(key);
  }

  @override
  Future<void> setObject<T>({required String key, required T value}) async {
    await hiveBox.put(key, value);
  }

  @override
  T getObject<T>({required String key}) {
    return hiveBox.get(key) as T;
  }


  Future<void> clearAllData() async {
  await hiveBox.clear();
  print("All data in Hive has been cleared.");
}
}
