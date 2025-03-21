import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/usecases/add_movie_to_history_use_case.dart';

part 'add_movie_to_history_state.dart';

class AddMovieToHistoryCubit extends Cubit<AddMovieToHistoryState> {
  AddMovieToHistoryCubit({required this.addMovieToHistoryUseCase})
      : super(AddMovieToHistoryInitial());

  AddMovieToHistoryUseCase addMovieToHistoryUseCase;

  addMovieToHistory({required MovieEntity movie}) {
    addMovieToHistoryUseCase.call(movie: movie);
  }
}
