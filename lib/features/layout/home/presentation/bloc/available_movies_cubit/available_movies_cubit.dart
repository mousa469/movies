import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_available_movies_use_case.dart';

part 'available_movies_state.dart';

class AvailableMoviesCubit extends Cubit<AvailableMoviesState> {
  AvailableMoviesCubit({required this.fetchAvailableMoviesUseCase})
      : super(AvailableMoviesInitial());

  FetchAvailableMoviesUseCase fetchAvailableMoviesUseCase;

  void fetchAvailabeMovies() async {
    emit(AvailableMoviesLoading());

    var result = await fetchAvailableMoviesUseCase.call();

    result.fold(
      (fail) {
        log("Emitting AvailableMoviesFailure");
        emit(AvailableMoviesFailure(errMessage: fail.errMessage));
      },
      (entity) {
        log("Emitting AvailableMoviesSuccess");
        emit(AvailableMoviesSuccess(movies: entity));
      },
    );
  }
}
