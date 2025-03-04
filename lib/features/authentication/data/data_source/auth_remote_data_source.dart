import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/constants.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/core/services/shared_prefs.dart';
import 'package:movies/features/authentication/data/models/sign_up_user_request.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, UserCredential>> createNewUser(SignUpUserRequest user);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.firebaseFirestore});
  @override
  Future<Either<Failure, UserCredential>> createNewUser(
      SignUpUserRequest user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.userEmail, password: user.password!);

      storeUserInfoInFirestore(userCredential, user);
      storeUserRegisterationInLocalStorage();
      storeUserInfoInLocalStorage(user, userCredential);
      return right(userCredential);
    } on FirebaseAuthException catch (firebaseAuthException) {
      return left(Failure(errMessage: firebaseAuthException.message!));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  void storeUserInfoInFirestore(
      UserCredential userCredential, SignUpUserRequest user) {
    CollectionReference users = firebaseFirestore.collection(usersCollection);
    user.userID = userCredential.user!.uid;
    users.add(user.toJson());
  }

  void storeUserInfoInLocalStorage(
      SignUpUserRequest user, UserCredential userCredential) {
    SharedPrefs.setString(SharedPrefs.userEmail, user.userEmail);
    SharedPrefs.setString(SharedPrefs.userID, userCredential.user!.uid);
    SharedPrefs.setString(SharedPrefs.userName, user.userEmail);
  }

  void storeUserRegisterationInLocalStorage() {
    SharedPrefs.setBool(SharedPrefs.isRegisteredBefore, true);
  }
}
