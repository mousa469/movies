import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/authentication/domain/entites/user_entity.dart';
import 'package:movies/features/authentication/domain/repository/auth_repository.dart';

class SignInWithFacebookUseCase {
  AuthRepository authRepository;
  SignInWithFacebookUseCase({required this.authRepository});
  Future<Either<Failure, UserEntity>> call() async {
    return await authRepository.signInWithFacebook();
  }
}
