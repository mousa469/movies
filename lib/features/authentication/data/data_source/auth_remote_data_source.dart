import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/core/services/firbase_auth_services.dart';
import 'package:movies/features/authentication/data/models/user_model.dart';
import 'package:movies/features/authentication/domain/entites/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, UserEntity>> createNewUser(
      {required String email, required String password});
  Future<Either<Failure, UserEntity>> signInUser(
      {required String email, required String password});
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithFacebook();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  FirebaseAuthServices firebaseAuthServices;
  FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl(
      {required this.firebaseAuthServices, required this.firebaseFirestore});
  @override
  Future<Either<Failure, UserEntity>> createNewUser(
      {required String email, required String password}) async {
    try {
      var user = await firebaseAuthServices.createNewUser(
          email: email, password: password);
      return right(UserModel.fromFirebase(user: user));
    } on CustomException catch (customEX) {
      return left(ServerFailure(errMessage: customEX.errMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInUser(
      {required String email, required String password}) async {
    try {
      User credential = await firebaseAuthServices.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(UserModel.fromFirebase(user: credential));
    } on FirebaseAuthException catch (fireBaseAuthException) {
      return Left(Failure(errMessage: fireBaseAuthException.message!));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      return right(UserModel.fromFirebase(
          user: await firebaseAuthServices.signInWithGoogle()));
    } on CustomException catch (e) {
      log("exception come from AuthRemoteDataSourceImp.signInWithGoogle and message is : ${e.errMessage}");
      return left(Failure(errMessage: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    try {
      var user = await firebaseAuthServices.signInWithFacebook();

      return right(UserModel.fromFirebase(user: user));
    } on CustomException catch (e) {
      return Left(Failure(errMessage: e.errMessage));
    }
  }
}
