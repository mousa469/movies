import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:movies/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:movies/features/authentication/data/models/sign_in_user_request.dart';
import 'package:movies/features/authentication/data/models/sign_up_user_request.dart';
import 'package:movies/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:movies/features/authentication/domain/repository/auth_repository.dart';
import 'package:movies/features/authentication/domain/use_cases/create_new_user_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_User_use_case.dart';
import 'package:movies/generated/l10n.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final AuthRemoteDataSourceImpl authRemoteDataSource =
        AuthRemoteDataSourceImpl(
            firebaseAuth: firebaseAuth,
            firebaseFirestore: FirebaseFirestore.instance);
    final AuthRepository authRepository =
        AuthRepositoryImpl(authRemoteDataSourceImpl: authRemoteDataSource);
    createNewUserUseCase = CreateNewUserUseCase(authRepository: authRepository);
    signInUserUseCase = SignInUserUseCase(authRepository: authRepository);
  }

  late final CreateNewUserUseCase createNewUserUseCase;
  late final SignInUserUseCase signInUserUseCase;
  Future<void> createNewUser(SignUpUserRequest user) async {
    emit(AuthLoading());
    var result = await createNewUserUseCase.call(user);
    result.fold((fail) {
      emit(AuthFailure(errMessage: fail.errMessage));
    }, (credetial) {
      emit(AuthSuccess(
        userCredential: credetial,
      ));
    });
  }

  Future<void> signInUser(SignInUserRequest user) async {
    emit(AuthLoading());
    var result = await signInUserUseCase.call(user);
    result.fold((fail) {
      emit(AuthFailure(errMessage: fail.errMessage));
    }, (credetial) {
      emit(AuthSuccess(userCredential: credetial));
    });
  }
}
