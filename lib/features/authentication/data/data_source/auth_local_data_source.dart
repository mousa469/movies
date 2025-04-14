import 'package:movies/core/services/local_storage/local_storage.dart';

abstract class AuthLocalDataSource {
  void createNewUser(
      {required String name,
      required String email,
      required String id,
      required String phone,
      required String signInMethode});

  void markUserAsRegistered();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  LocalStorage localStorage;
  AuthLocalDataSourceImpl({required this.localStorage});
  @override
  void createNewUser(
      {required String name,
      required String email,
      required String id,
      required String phone,
      required String signInMethode}) {
    localStorage.storeUserInfoInLocalStorage(
        email: email,
        name: name,
        uid: id,
        phone: phone,
        signInMethode: signInMethode);
  }

  @override
  void markUserAsRegistered() {
    localStorage.markUserIsRegistered();
  }
}
