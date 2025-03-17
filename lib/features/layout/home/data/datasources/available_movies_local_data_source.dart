import 'dart:convert';
import 'dart:developer';

import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/shared_prefs.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class AvailableMoviesLocalDataSource {
  void cacheLastAvailableMovies({List<MovieModel>? movies});
  Future<List<MovieModel>> fetchAvailableMovies();
}

class AvailableMoviesLocalDataSourceImpl
    extends AvailableMoviesLocalDataSource {
  // AvailableMoviesLocalDataSourceImpl({required this.sharedPrefs});
  @override
  void cacheLastAvailableMovies({List<MovieModel>? movies}) {
    if (movies != null) {
      SharedPrefs.setString(
          key: SharedPrefs.lastAvailableMoviesList,
          value: jsonEncode(movies.map((movie) => movie.toJson()).toList()));
    } else {
      log("exception from AvailableMoviesLocalDataSourceImpl.cacheLastAvailableMovies ");
      throw CachException(errMessage: "list of movies is null");
    }
  }

  @override
  Future<List<MovieModel>> fetchAvailableMovies() async {
    String? movies =
        await SharedPrefs.getString(key: SharedPrefs.lastAvailableMoviesList);

    if (movies != null) {
      List<dynamic> decodedMovies = jsonDecode(movies);

      List<MovieModel> movieList = [];

      for (var movie in decodedMovies) {
        movieList.add(MovieModel.fromJson(movie as Map<String,dynamic>));
      }

      return movieList;
    } else {
      log("exception from AvailableMoviesLocalDataSourceImpl.fetchAvailableMovies ");

      throw CachException(errMessage: "no internet connection");
    }
  }
}
