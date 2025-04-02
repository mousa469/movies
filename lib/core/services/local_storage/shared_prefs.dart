// import 'package:movies/core/services/local_storage/local_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefs extends LocalStorage {
//   static late SharedPreferences sharedPreferences;
  

//   @override
//   Future<void> init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }

//   @override
//   Future<void> setString({required String key, required String value}) async {
//     await sharedPreferences.setString(key, value);
//   }

//   @override
//   String? getString({required String key}) {
//     return sharedPreferences.getString(key);
//   }

//   @override
//   Future<void> setBool({required String key, required bool value}) async {
//     await sharedPreferences.setBool(key, value);
//   }

//   @override
//   bool? getBool({required String key}) {
//     return sharedPreferences.getBool(key);
//   }

//   @override
//   Future<void> setDouble({required String key, required double value}) async {
//     await sharedPreferences.setDouble(key, value);
//   }

//   @override
//   double? getDouble({required String key}) {
//     return sharedPreferences.getDouble(key);
//   }

//   @override
//   Future<void> setInt({required String key, required int value}) async {
//     await sharedPreferences.setInt(key, value);
//   }

//   @override
//   int? getInt({required String key}) {
//     return sharedPreferences.getInt(key);
//   }



//   @override
//   void markUserIsLogined() {
//     setBool(key: LocalStorage.isLoginedBefore, value: true);
//   }

//   @override
//   void storeUserInfoInLocalStorage({required String email, required String name, required String uid}) {
//     setString(key:LocalStorage. userEmail, value: email);
//     setString(key:LocalStorage. userID, value: uid);
//     setString(key:LocalStorage. userName, value: name);
//     markUserIsRegistered();
//   }

//   @override
//   void markUserIsRegistered() {
//     setBool(key: LocalStorage.isRegisteredBefore, value: true);
//   }

//   @override
//   Future<void> clearData({required String key}) async {
//     await sharedPreferences.remove(key);
//   }
  
//   @override
//   getObject({required String key}) {
//     // TODO: implement getObject
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<void> setObject({required String key, required value}) {
//     // TODO: implement setObject
//     throw UnimplementedError();
//   }
  
//   @override
//   List<T>? getList<T>({required String key}) {
//     // TODO: implement getList
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<void> setList<T>({required String key, required List<T> value}) {
//     // TODO: implement setList
//     throw UnimplementedError();
//   }
// }
