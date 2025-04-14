import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/profile/data/models/user_profile_model.dart';

abstract class UserDataLocalDataSource {
  UserProfileModel fetchUserData();
  void storeUserData({required UserProfileModel user});
}

class UserDataLocalDataSourceImpl extends UserDataLocalDataSource {
  LocalStorage localStorage;
  UserDataLocalDataSourceImpl({required this.localStorage});
  @override
  UserProfileModel fetchUserData() {
    try {
      UserProfileModel? userProfileModel = UserProfileModel(
          name: localStorage.getString(key: LocalStorage.userName)!,
          phone: localStorage.getString(key: LocalStorage.userPhone)!);
      return userProfileModel;
        } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  void storeUserData({required UserProfileModel user}) {
    try {
      localStorage.setString(key: LocalStorage.userName, value: user.name);
      localStorage.setString(key: LocalStorage.userPhone, value: user.phone);
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }
}
