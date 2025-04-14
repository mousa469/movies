import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';

abstract class UpdateUserDataLocalDataSource {
  void updateUserData({String? userName, String? userPhone});
}

class UpdateUserDataLocalDataSourceImpl extends UpdateUserDataLocalDataSource {
  LocalStorage localStorage;
  UpdateUserDataLocalDataSourceImpl({required this.localStorage});

  @override
  void updateUserData({String? userName, String? userPhone}) {
    try {
      localStorage.setString(key: LocalStorage.userName, value: userName!);
      localStorage.setString(key: LocalStorage.userPhone, value: userPhone!);
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }
}
