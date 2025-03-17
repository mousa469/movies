import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/authentication/data/models/user_model.dart';
import 'package:movies/features/authentication/domain/entites/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> createNewUser(
      {required String email,
      required String password,
      required String name,
      required String phone});
  Future<Either<Failure, UserEntity>> signInUser(
      {required String email, required String password});
  Future addUserToDataBase({required UserEntity user});
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithFacebook();
}
