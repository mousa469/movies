import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/authentication/data/models/sign_up_user_request.dart';

abstract class AuthRepository {
  Future<Either<Failure,UserCredential> > createNewUser(SignUpUserRequest user );
}
