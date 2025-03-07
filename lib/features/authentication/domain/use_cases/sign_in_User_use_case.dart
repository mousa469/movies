import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/authentication/data/models/sign_in_user_request.dart';
import 'package:movies/features/authentication/domain/repository/auth_repository.dart';

class SignInUserUseCase {
  AuthRepository authRepository;

  SignInUserUseCase({required this.authRepository});

  Future<Either<Failure, UserCredential>> call(SignInUserRequest user) {
    return authRepository.signInUser(user);
  }
}
