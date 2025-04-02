import 'dart:developer';
import 'package:movies/core/services/local_storage/hive.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

abstract class AddMovieToWishListLocalDataSource {
  Future<void> addMovieToWishList({required MovieEntity movie});
  Future<List<MovieEntity>> getWishList();
}

class AddMovieToWishListLocalDataSourceImpl
    implements AddMovieToWishListLocalDataSource {
  final LocalStorage localStorage;

  AddMovieToWishListLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> addMovieToWishList({required MovieEntity movie}) async {
    try {
      List<MovieEntity> oldMoviesWishList =
          localStorage.getList(key: LocalStorage.wishList) ?? [];

      bool movieIsExist = checkIfTheMovieExistBefore(
          cachedMovies: oldMoviesWishList, movie: movie);

      if (!movieIsExist) {
        oldMoviesWishList.add(movie);
        log("movie not exist in the wish list before (added)");
        await localStorage.setList(
            key: LocalStorage.wishList, value: oldMoviesWishList);

        print(
            " exist wish list :  ${HiveStorage().getList(key: LocalStorage.wishList)}");
      } else {
        log("movie is exist in the wish list before (not added)");
      }
    } catch (e) {
      log("Exception in addMovieToWishList: ${e.toString()}");
      throw Exception("Failed to add movie to wishlist.");
    }
  }

  @override
  Future<List<MovieEntity>> getWishList() async {
    try {
      List<MovieEntity>? movies =
          localStorage.getList(key: LocalStorage.wishList);

      if (movies != null && movies.isNotEmpty) {
        return movies;
      } else {
        log("no movies avialable to fetch  in cache ");
        throw ("No internet Connection , please check your network");
      }
    } catch (e) {
      log("Exception in getWishList: ${e.toString()}");
      throw Exception("Failed to fetch wishlist.");
    }
  }

  bool checkIfTheMovieExistBefore(
      {required MovieEntity movie, required List<MovieEntity> cachedMovies}) {
    for (int i = 0; i < cachedMovies.length; i++) {
      if (movie.id == cachedMovies[i].id) {
        return true;
      }
    }
    return false;
  }
}
