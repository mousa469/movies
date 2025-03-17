import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/usecases/fetch_watch_now_movies_use_case.dart';

part 'watch_now_state.dart';

class WatchNowCubit extends Cubit<WatchNowState> {
  WatchNowCubit({required this.watchNowMoviesUseCase})
      : super(WatchNowInitial());

  FetchWatchNowMoviesUseCase watchNowMoviesUseCase;

  fetchWatchNowMovies() async {
    log("before  emitting watch now loading ");
    emit(WatchNowLoading());
    log("after  emitting watch now loading ");

    var result = await watchNowMoviesUseCase.call();
    result.fold((fail) {
      emit(WatchNowFailure(errMessage: fail.errMessage));
    }, (movies) {
      log("before  emitting watch now success ");
      emit(WatchNowSuccess(movies: movies));
      log("after  emitting watch now loading ");
    });
  }
}
