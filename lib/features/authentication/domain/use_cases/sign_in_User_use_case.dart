import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/authentication/domain/entites/user_entity.dart';
import 'package:movies/features/authentication/domain/repository/auth_repository.dart';

class SignInUserUseCase {
  AuthRepository authRepository;

  SignInUserUseCase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call({required String email, required String password}) {
    return authRepository.signInUser(email: email , password: password );
  }
}
