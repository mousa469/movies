
import 'package:movies/core/services/local_storage/local_storage.dart';


abstract class AuthLocalDataSource {
  void createNewUser(
      {required String name, required String email, required String id});

  void markUserAsRegistered();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  LocalStorage localStorage;
  AuthLocalDataSourceImpl({required this.localStorage});
  @override
  void createNewUser(
      {required String name, required String email, required String id}) {
    localStorage.storeUserInfoInLocalStorage(email: email, name: name, uid: id);
  }

  @override
  void markUserAsRegistered() {
    localStorage.markUserIsRegistered();
  }
}
