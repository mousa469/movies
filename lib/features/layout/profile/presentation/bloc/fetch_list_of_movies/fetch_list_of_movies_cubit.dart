import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_list_of_movies_in_history_use_case.dart';
import 'package:movies/features/layout/profile/domain/usecases/fetch_list_of_movies_in_watch_list_use_case.dart';

part 'fetch_list_of_movies_state.dart';

class FetchListOfMoviesyCubit extends Cubit<FetchListOfMoviesState> {
  FetchListOfMoviesyCubit(
      {required this.fetchListOfMoviesInHistoryUseCase,
      required this.fetchListOfMoviesInWatchListUseCase})
      : super(FetchListOfMoviesInitial());

  FetchListOfMoviesInHistoryUseCase fetchListOfMoviesInHistoryUseCase;
  FetchListOfMoviesInWatchListUseCase fetchListOfMoviesInWatchListUseCase;

  int index = 0;

  Future<void> fetchListOfMoviesInHistory() async {
    log("index in the cubit : $index");
    if (index == 1) {
      emit(FetchListOfMoviesLoading());

      var result = await fetchListOfMoviesInHistoryUseCase.call();

      result.fold((fail) {
        emit(FetchListOfMoviesFailure(errMessage: fail.errMessage));
      }, (movies) {
        emit(FetchListOfMoviesSuccess(movies: movies));
      });
    } else {
      emit(FetchListOfMoviesLoading());

      var result = await fetchListOfMoviesInWatchListUseCase.call();

      result.fold((fail) {
        emit(FetchListOfMoviesFailure(errMessage: fail.errMessage));
      }, (movies) {
        emit(FetchListOfMoviesSuccess(movies: movies));
      });
    }
  }
}
