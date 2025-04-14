import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/features/layout/profile/domain/usecases/update_user_data_use_case.dart';

part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  UpdateUserDataCubit({required this.updateUserDataUseCase})
      : super(UpdateUserDataInitial());

  UpdateUserDataUseCase updateUserDataUseCase;

  void updateUserData({String? userName, String? userPhone}) async {
    emit(UpdateUserDataLoading());
    var result = await updateUserDataUseCase.call(
      userName: userName,
      userPhone: userPhone,
    );

    result.fold((Fail) {
      emit(UpdateUserDataFailure(errMessage: Fail.errMessage));
    }, (success) {
      emit(UpdateUserDataSuccess());
    });
  }
}
