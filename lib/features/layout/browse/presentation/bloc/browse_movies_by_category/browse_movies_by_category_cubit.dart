import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/features/layout/browse/domain/usecases/browse_item_by_category_use_case.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

part 'browse_movies_by_category_state.dart';

class BrowseMoviesByCategoryCubit extends Cubit<BrowseMoviesByCategoryState> {
  BrowseMoviesByCategoryCubit({required this.browseItemByCategoryUseCase})
      : super(BrowseMoviesByCategoryInitial());

  BrowseMovieByCategoryUseCase browseItemByCategoryUseCase;

  Future<void> getMoviesByCategory({required String category}) async {
    emit(BrowseMoviesByCategoryLoading());
    final result = await browseItemByCategoryUseCase.call(category: category);
    result.fold(
        (fail) =>
            emit(BrowseMoviesByCategoryFailure(errMessage: fail.errMessage)),
        (movies) => emit(BrowseMoviesByCategorySuccess(movies: movies)));
  }
}
