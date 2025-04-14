import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/profile/data/models/user_profile_model.dart';

abstract class FetchUserDataRemoteDataSource {
  Future<UserProfileModel> fetchUserData();
}

class FetchUserDataRemoteDataSourceImpl extends FetchUserDataRemoteDataSource {
  DatabaseServices databaseServices;
  LocalStorage localStorage;
  FetchUserDataRemoteDataSourceImpl(
      {required this.databaseServices, required this.localStorage});
  @override
  Future<UserProfileModel> fetchUserData() async {
    return UserProfileModel.fromJson(await databaseServices.fetchData(
        path: EndPoints.users,
        id: localStorage.getString(key: LocalStorage.userID)));
  }
}
