import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/features/layout/profile/domain/entities/user_profile_entity.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_user_data_use_case.dart';

part 'fetch_user_data_state.dart';

class FetchUserDataCubit extends Cubit<FetchUserDataState> {
  FetchUserDataCubit({required this.fetchUserDataUseCase})
      : super(FetchUserDataInitial());

  FetchUserDataUseCase fetchUserDataUseCase;

  void fetchUserData() async {
    emit(FetchUserDataLoading());
    var result = await fetchUserDataUseCase.call();
    result.fold((fail) {
      emit(FetchUserDataFailure(errMessage: fail.errMessage));
    }, (user) {
      emit(FetchUserDataSuccess(user: user));
    });
  }
}
