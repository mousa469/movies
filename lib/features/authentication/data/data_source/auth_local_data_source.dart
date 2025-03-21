import 'dart:math';

import 'package:movies/core/services/shared_prefs.dart';
import 'package:movies/features/authentication/data/models/sign_up_user_request.dart';
import 'package:movies/features/authentication/data/models/user_model.dart';
import 'package:movies/features/authentication/domain/entites/user_entity.dart';

abstract class AuthLocalDataSource {
  void createNewUser({required String name, required String email, required String id});

  void markUserAsRegistered();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  @override
  void createNewUser(
      {required String name, required String email, required String id}) {
    SharedPrefs.storeUserInfoInLocalStorage(email: email, name: name, uid: id);
  }

  @override
  void markUserAsRegistered() {
    SharedPrefs.markUserIsRegistered();
  }
}
