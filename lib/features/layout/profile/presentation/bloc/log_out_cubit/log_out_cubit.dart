import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/features/layout/profile/domain/usecases/log_out_use_case.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit({required this.logOutUseCase}) : super(LogOutInitial());
  LogOutUseCase logOutUseCase;

  void logOut() async {
    var result = await logOutUseCase.call();
    result.fold((fail) {
      emit(LogOutFailure(errMessage: fail.errMessage));
    }, (success) {
      emit(LogOutSuccess(successMessage: "Logged out successfully"));
    });
  }
}
