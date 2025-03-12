import 'package:movies/core/services/shared_prefs.dart';
import 'package:movies/features/authentication/data/models/sign_up_user_request.dart';
import 'package:movies/features/authentication/data/models/user_model.dart';
import 'package:movies/features/authentication/domain/entites/user_entity.dart';

abstract class AuthLocalDataSource {
  void createNewUser({ required UserModel userModel});

  void markUserAsRegistered();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  @override
  void createNewUser({ required UserModel userModel}) {
    SharedPrefs.storeUserInfoInLocalStorage(userModel: userModel);
  }

  @override
  void markUserAsRegistered() {
    SharedPrefs.markUserIsRegistered();
  }
}
