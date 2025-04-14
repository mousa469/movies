import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';

abstract class UpdateUserDataRemoteDataSource {
  Future<void> updateUserData({String? userName, String? userPhone});
}

class UpdateUserDataRemoteDataSourceImpl
    extends UpdateUserDataRemoteDataSource {
  DatabaseServices databaseServices;
  LocalStorage localStorage;
  UpdateUserDataRemoteDataSourceImpl(
      {required this.databaseServices, required this.localStorage});
  @override
  Future<void> updateUserData({String? userName, String? userPhone}) {
    try {
      return databaseServices.updateUserData(
          userName: userName,
          userPhone: userPhone,
          userID: localStorage.getString(key: LocalStorage.userID)!);
    } catch (e) {
      throw ServerException(errMessage: e.toString());
    }
  }
}
