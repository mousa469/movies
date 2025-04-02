import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_similar_movies_use_case.dart';

part 'fetch_similar_movies_state.dart';

class FetchSimilarMoviesCubit extends Cubit<FetchSimilarMoviesState> {
  FetchSimilarMoviesCubit({required this.fetchSimilarMoviesUseCase})
      : super(FetchSimilarMoviesInitial());
  FetchSimilarMoviesUseCase fetchSimilarMoviesUseCase;

  void fetchSimilarMovies({required int id}) async {
    emit(FetchSimilarMoviesLoading());
    var result = await fetchSimilarMoviesUseCase.call(id: id);

    result.fold((fail) {
      emit(FetchSimilarMoviesFailure(errMessage: fail.errMessage));
    }, (movies) {
      emit(FetchSimilarMoviesSucces(movies: movies));
    });
  }
}
