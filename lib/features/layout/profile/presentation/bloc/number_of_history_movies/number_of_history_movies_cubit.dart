import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_number_of_movies_in_history.dart';

part 'number_of_history_movies_state.dart';

class NumberOfHistoryMoviesCubit extends Cubit<NumberOfHistoryMoviesState> {
  NumberOfHistoryMoviesCubit(
      {required this.fetchNumberOfMoviesInHistoryUseCase})
      : super(NumberOfHistoryMoviesInitial());

  FetchNumberOfMoviesInHistoryUseCase fetchNumberOfMoviesInHistoryUseCase;

  void fetchNumberOfMoviesInHistory() async {
    emit(NumberOfHistoryMoviesLoading());
    var result = await fetchNumberOfMoviesInHistoryUseCase.call();

    result.fold((fail) {
      emit(NumberOfHistoryMoviesFailure(errMessage: fail.errMessage));
    }, (moviesNumber) {
      emit(NumberOfHistoryMoviesSuccess(numberOfMovies: moviesNumber));
    });
  }
}
