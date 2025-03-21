import 'dart:convert';

import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/shared_prefs.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

abstract class AddMovieToWishListLocalDataSource {
  void addMovieToWishList({required MovieEntity movie});
}

class AddMovieToWishListLocalDataSourceimpl
    extends AddMovieToWishListLocalDataSource {
  @override
  void addMovieToWishList({required MovieEntity movie})  {
    try {
      List<String>? wishList =
          SharedPrefs.getList(key: SharedPrefs.wishList) ?? [];

      String stringMovie = jsonEncode(movie.toJson());

      if (!wishList.contains(stringMovie)) {
        wishList.add(stringMovie);
        SharedPrefs.setList(key: SharedPrefs.wishList, value: wishList);
      }
    } catch (e) {
      throw CachException(errMessage: e.toString());
    }
  }
}
