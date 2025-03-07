import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/constants.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/core/services/shared_prefs.dart';
import 'package:movies/features/authentication/data/models/sign_in_user_request.dart';
import 'package:movies/features/authentication/data/models/sign_up_user_request.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, UserCredential>> createNewUser(SignUpUserRequest user);
  Future<Either<Failure, UserCredential>> signInUser(SignInUserRequest user);
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
    SharedPrefs.setString(key: SharedPrefs.userEmail, value: user.userEmail);
    SharedPrefs.setString(
        key: SharedPrefs.userID, value: userCredential.user!.uid);
    SharedPrefs.setString(key: SharedPrefs.userName, value: user.userEmail);
  }

  void storeUserRegisterationInLocalStorage() {
    SharedPrefs.setBool(key: SharedPrefs.isRegisteredBefore, value: true);
  }

  @override
  Future<Either<Failure, UserCredential>> signInUser(
      SignInUserRequest user) async {
    try {
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      storeUserLoginedBeforeInLocalStorage();
      return Right(credential);
    } on FirebaseAuthException catch (fireBaseAuthException) {
      return Left(Failure(errMessage: fireBaseAuthException.message!));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  void storeUserLoginedBeforeInLocalStorage() {
    SharedPrefs.setBool(key: SharedPrefs.isLoginedBefore, value: true);
  }
}
