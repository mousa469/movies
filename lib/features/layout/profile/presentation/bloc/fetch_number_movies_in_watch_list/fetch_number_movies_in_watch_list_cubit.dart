import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_number_of_watch_list_movies_use_case.dart';

part 'fetch_number_movies_in_watch_list_state.dart';

class FetchNumberMoviesInWatchListCubit
    extends Cubit<FetchNumberMoviesInWatchListState> {
  FetchNumberMoviesInWatchListCubit(
      {required this.fetchNumberOfWatchListMoviesUseCase})
      : super(FetchNumberMoviesInWatchListInitial());

  FetchNumberOfWatchListMoviesUseCase fetchNumberOfWatchListMoviesUseCase;

  void FetchNumberOfWatchListMovies() async {
    emit(FetchNumberMoviesInWatchListLoading());
    var result = await fetchNumberOfWatchListMoviesUseCase.call();

    result.fold((fail) {
      emit(FetchNumberMoviesInWatchListFailure(errMessage: fail.errMessage));
    }, (numberOfMovies) {
      emit(FetchNumberMoviesInWatchListSuccess(numberOfMovies: numberOfMovies));
    });
  }
}
