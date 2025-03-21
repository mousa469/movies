import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/usecases/add_movie_to_wish_list_use_case.dart';

part 'add_movie_to_wishlist_state.dart';

class AddMovieToWishlistCubit extends Cubit<AddMovieToWishlistState> {
  AddMovieToWishlistCubit({required this.addMovieToWishListUseCase})
      : super(AddMovieToWishlistInitial());

  AddMovieToWishListUseCase addMovieToWishListUseCase;

  void addMovieToWishList({required MovieEntity movie}) async {
    var result = await addMovieToWishListUseCase.call(movie: movie);

    result.fold((fail) {
      emit(AddMovieToWishlistFailure(errMessage: fail.errMessage));
    }, (success) {
      emit(AddMovieToWishlistSuccess());
    });
  }
}
