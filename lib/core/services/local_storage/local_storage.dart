abstract class LocalStorage {
  static const String isOnBoardingSeenBefore = "isOnBoardingSeenBefore";
  static const String isRegisteredBefore = "isRegisteredBefore";
  static const String userEmail = "userEmail";
  static const String userName = "userName";
  static const String userID = "userID";
  static const String userInfo = "userInfo";
  static const String isLoginedBefore = "isLoginedBefore";
  static const String lastAvailableMoviesList = "lastMoviesList";
  static const String lastWatchNowMoviesList = "lastWatchNowMoviesList";
  static const String wishList = "wishList";
  static const String history = "history";
  static const String userPhone = "userPhone";
  static const String signInMethode = "signInMethode";
  static const String numberOfHistoryMovies = "numberOfHistoryMovies";
  static const String numberOfWatchListMovies = "numberOfWatchListMovies";
  Future<void> init();
  Future<void> setString({required String key, required String value});
  String? getString({required String key});
  Future<void> setBool({required String key, required bool value});
  bool? getBool({required String key});
  Future<void> setDouble({required String key, required double value});
  double? getDouble({required String key});
  Future<void> setInt({required String key, required int value});
  int? getInt({required String key});
  Future<void> setList<T>({required String key, required List<T> value});
  List<T>? getList<T>({required String key});
  void markUserIsLogined();
  void storeUserInfoInLocalStorage(
      {required String email,
      required String name,
      required String uid,
      required String phone,
      required String signInMethode});
  void markUserIsRegistered();
  Future<void> clearData({required String key});
  Future<void> setObject<T>({required String key, required T value});
  T? getObject<T>({required String key});
  Future<void> clearAllData();
}
