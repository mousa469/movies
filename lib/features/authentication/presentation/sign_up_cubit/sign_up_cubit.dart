
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/features/authentication/data/models/sign_up_user_request.dart';
import 'package:movies/features/authentication/data/models/user_model.dart';
import 'package:movies/features/authentication/domain/entites/user_entity.dart';
import 'package:movies/features/authentication/domain/use_cases/create_new_user_use_case.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.createNewUserUseCase) : super(SignUpInitial()) {}

  CreateNewUserUseCase createNewUserUseCase;

  Future<void> createNewUser({required  String  email ,required String password , required String name , required String phone}) async {
    emit(SignUpLoading());
    var result = await createNewUserUseCase.call(email: email ,  password:password , name: name , phone: phone );
    result.fold((fail) {
      emit(SignUpFailure(errMessage: fail.errMessage));
    }, (UserEntity) {
      emit(SignUpSuccess(
        userEntity: UserEntity,
      ));
    });
  }

  // Future<void> signInUser(SignInUserRequest user) async {
  //   emit(AuthLoading());
  //   var result = await signInUserUseCase.call(user);
  //   result.fold((fail) {
  //     emit(AuthFailure(errMessage: fail.errMessage));
  //   }, (credetial) {
  //     emit(AuthSuccess(userCredential: credetial));
  //   });
  // }
}
