import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';

import 'package:movies/features/authentication/domain/entites/user_entity.dart';
import 'package:movies/features/authentication/domain/repository/auth_repository.dart';

class CreateNewUserUseCase {
  AuthRepository authRepository;

  CreateNewUserUseCase({required this.authRepository});

   Future<Either<Failure,UserEntity> >call({required String email , required  String password , required String name , required String phone }) {
    return authRepository.createNewUser(email: email , password: password , name: name , phone: phone);
  }
}
