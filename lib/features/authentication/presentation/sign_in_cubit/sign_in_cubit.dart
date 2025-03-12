import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/features/authentication/domain/entites/user_entity.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_User_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_with_facebook_use_case.dart';
import 'package:movies/features/authentication/domain/use_cases/sign_in_with_google_use_case.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
      {required this.signInUserUseCase, required this.signInWithGoogleUseCase  ,required this.signInWithFacebookUseCase})
      : super(SignInInitial());

  SignInUserUseCase signInUserUseCase;
  SignInWithGoogleUseCase signInWithGoogleUseCase;
  SignInWithFacebookUseCase signInWithFacebookUseCase;

  Future<void> signInUser(
      {required String email, required String password}) async {
    emit(SignInLoading());
    var result = await signInUserUseCase.call(email: email, password: password);
    result.fold((fail) {
      emit(SignInFailure(errMessage: fail.errMessage));
    }, (user) {
      emit(SignInSuccess(user: user));
    });
  }

  Future<void> signInWithGoogle() async {
    emit(SignInLoading());
    var result = await signInWithGoogleUseCase.call();
    result.fold((fail) {
      emit(SignInFailure(errMessage: fail.errMessage));
    }, (user) {
      emit(SignInSuccess(user: user));
    });
  }

  Future<void> signInWithFacebook() async {
    emit(SignInLoading());
    var result = await signInWithFacebookUseCase.call();
    result.fold((fail) {
      emit(SignInFailure(errMessage: fail.errMessage));
    }, (user) {
      emit(SignInSuccess(user: user));
    });
  }
}
