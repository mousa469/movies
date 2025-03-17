import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/authentication/data/data_source/auth_local_data_source.dart';
import 'package:movies/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:movies/features/authentication/domain/entites/user_entity.dart';
import 'package:movies/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });
  @override
  Future<Either<Failure, UserEntity>> createNewUser(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    var result = await authRemoteDataSource.createNewUser(
        password: password, email: email , name: name , phone: phone);
        

    return result;
  }

  @override
  Future<Either<Failure, UserEntity>> signInUser(
      {required String email, required String password}) {
    return authRemoteDataSource.signInUser(email: email, password: password);
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    return await authRemoteDataSource.signInWithGoogle();
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    return await authRemoteDataSource.signInWithFacebook();
  }

  @override
  Future addUserToDataBase({required UserEntity user}) async {
    try {
      await authRemoteDataSource.addUserToDatabase(user: user);
    } catch (e) {
      log("exception come from AuthRepositoryImpl.addUserToDataBase and  message is : ${e.toString()} ");

    }
  }
}
