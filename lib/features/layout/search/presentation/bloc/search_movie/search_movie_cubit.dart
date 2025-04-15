import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/search/domain/usecases/search_movies_use_case.dart';

part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  SearchMovieCubit({required this.searchMoviesUseCase})
      : super(SearchMovieInitial());
  SearchMoviesUseCase searchMoviesUseCase;
  Future<void> search({required String query}) async {
    emit(SearchMovieLoading());
    final result = await searchMoviesUseCase.call(query: query);
    result.fold(
        (failure) => emit(SearchMovieFailure(message: failure.errMessage)),
        (movies) => emit(SearchMovieSuccess(movies: movies)));
  }
}
