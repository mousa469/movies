import 'dart:convert';

import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/shared_prefs.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

abstract class AddMovieToHistoryLocalDataSource {
  void addMovieToHistory({required MovieEntity movie});
}

class AddMovieToHistoryLocalDataSourceImpl
    extends AddMovieToHistoryLocalDataSource {
  @override
  void addMovieToHistory({required MovieEntity movie}) {
    try {
      List<String>? history =
          SharedPrefs.getList(key: SharedPrefs.history) ?? [];

      String stringMovie = jsonEncode(movie.toJson());

      if (!history.contains(stringMovie)) {
        history.add(stringMovie);
        SharedPrefs.setList(key: SharedPrefs.wishList, value: history);
      }
    } catch (e) {
      throw CachException(errMessage: e.toString());
    }
  }
}
