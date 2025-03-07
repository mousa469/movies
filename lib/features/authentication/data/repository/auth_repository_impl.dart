import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:movies/features/authentication/data/models/sign_in_user_request.dart';
import 'package:movies/features/authentication/data/models/sign_up_user_request.dart';
import 'package:movies/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRemoteDataSourceImpl authRemoteDataSourceImpl;

  AuthRepositoryImpl({required this.authRemoteDataSourceImpl});
  @override
  Future<Either<Failure, UserCredential>> createNewUser(
      SignUpUserRequest user) {
    return authRemoteDataSourceImpl.createNewUser(user);
  }

  @override
  Future<Either<Failure, UserCredential>> signInUser(SignInUserRequest user) {
    return authRemoteDataSourceImpl.signInUser(user);
  }
}
