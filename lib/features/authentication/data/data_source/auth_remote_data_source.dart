import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/core/services/firbase_auth_services.dart';
import 'package:movies/core/services/shared_prefs.dart';
import 'package:movies/features/authentication/data/models/user_model.dart';
import 'package:movies/features/authentication/domain/entites/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future deleteUSer();
  Future<Either<Failure, UserEntity>> createNewUser(
      {required String email,
      required String password,
      required String name,
      required String phone});
  Future<Either<Failure, UserEntity>> signInUser(
      {required String email, required String password});
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithFacebook();
  Future addUserToDatabase({required UserEntity user});
  Future<UserEntity> fetchUserData({required String id});
  Future<bool> checkIfUserExist({required String id});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  FirebaseAuthServices firebaseAuthServices;
  FirebaseFirestore firebaseFirestore;
  DatabaseServices databaseServices;

  AuthRemoteDataSourceImpl(
      {required this.firebaseAuthServices,
      required this.firebaseFirestore,
      required this.databaseServices});
  @override
  Future<Either<Failure, UserEntity>> createNewUser(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    User? user;
    try {
      user = await firebaseAuthServices.createNewUser(
          email: email, password: password);
      UserEntity userEntity = UserEntity(
          name: name, email: email, uid: user.uid, phoneNumber: phone);

      addUserToDatabase(user: userEntity);
      SharedPrefs.storeUserInfoInLocalStorage(
          email: email, uid: user.uid, name: name);
      return right(UserModel.fromFirebase(user: user));
    } on CustomException catch (customEX) {
      if (user != null) {
        deleteUSer();
      }
      log("custom exception come from AuthRemoteDataSourceImp.createNewUser and message is : ${customEX.errMessage}");

      return left(ServerFailure(errMessage: customEX.errMessage));
    } catch (e) {
      if (user != null) {
        deleteUSer();
      }
      log("general  exception come from AuthRemoteDataSourceImp.createNewUser and message is : ${e.toString()}");

      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInUser(
      {required String email, required String password}) async {
    try {
      User credential = await firebaseAuthServices.signInWithEmailAndPassword(
          email: email, password: password);

      UserEntity userEntity = await fetchUserData(id: credential.uid);

      return Right(userEntity);
    } on FirebaseAuthException catch (fireBaseAuthException) {
      return Left(Failure(errMessage: fireBaseAuthException.message!));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthServices.signInWithGoogle();
      UserEntity userEntity = UserModel.fromFirebase(user: user);
      var isExist = await checkIfUserExist(id: userEntity.uid);
      if (!isExist) {
        await addUserToDatabase(user: userEntity);
      } else {
        await fetchUserData(id: userEntity.uid);
      }
      SharedPrefs.storeUserInfoInLocalStorage(
          email: user.email!, uid: user.uid, name: user.displayName ?? "");

      return right(UserModel.fromFirebase(user: user));
    } on CustomException catch (e) {
      if (user != null) {
        deleteUSer();
      }
      log("exception come from AuthRemoteDataSourceImp.signInWithGoogle and message is : ${e.errMessage}");
      return left(Failure(errMessage: e.errMessage));
    } catch (e) {
      if (user != null) {
        deleteUSer();
      }
      return left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthServices.signInWithFacebook();
      UserEntity userEntity = UserModel.fromFirebase(user: user);
      addUserToDatabase(user: userEntity);
      SharedPrefs.storeUserInfoInLocalStorage(
          email: user.email!, uid: user.uid, name: user.displayName ?? "");

      return right(UserModel.fromFirebase(user: user));
    } on CustomException catch (e) {
      if (user != null) {
        deleteUSer();
      }
      log("custom  exception come from signInWithFacebook and message is : ${e.errMessage}   ");
      return Left(Failure(errMessage: e.errMessage));
    } catch (e) {
      if (user != null) {
        deleteUSer();
      }
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future addUserToDatabase({required UserEntity user}) async {
    try {
      await databaseServices.storeData(
          id: user.uid, path: EndPoints.users, data: user.toMap());
    } catch (e) {
      log("exception come from AuthRemoteDataSourceImpl.addUserToDatabase and message is : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  @override
  Future deleteUSer() async {
    try {
      await firebaseAuthServices.deleteUserAccount();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<UserEntity> fetchUserData({required String id}) async {
    return UserEntity.fromJson(
        await databaseServices.fetchData(path: EndPoints.users, id: id));
  }

  @override
  Future<bool> checkIfUserExist({required String id}) async {
    return await databaseServices.checkIfDataExist(
        path: EndPoints.users, id: id);
  }
}
