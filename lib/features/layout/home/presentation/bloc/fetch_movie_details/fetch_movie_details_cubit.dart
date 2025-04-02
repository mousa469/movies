import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/features/layout/home/domain/entities/movie_details_entity.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_movie_details_use_case.dart';

part 'fetch_movie_details_state.dart';

class FetchMovieDetailsCubit extends Cubit<FetchMovieDetailsState> {
  FetchMovieDetailsCubit({required this.fetchMovieDetailsUseCase})
      : super(FetchMovieDetailsInitial());

  FetchMovieDetailsUseCase fetchMovieDetailsUseCase;

  void fetchMovieDetails({required int movieID}) async {
    emit(FetchMovieDetailsLoading());
    var result = await fetchMovieDetailsUseCase.call(movieID: movieID);

    result.fold((Fail) {
      emit(FetchMovieDetailsFailure(errMessage: Fail.errMessage));
    }, (movie) {
      log(" before fetch movie details success state ");
      emit(FetchMovieDetailsSuccess(movie: movie));
      log(" after fetch movie details success state ");
    });
  }
}
