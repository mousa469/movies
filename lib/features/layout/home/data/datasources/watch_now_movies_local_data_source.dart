import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/shared_prefs.dart';
import 'package:movies/features/authentication/data/models/user_model.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class WatchNowMoviesLocalDataSource {
  Future<List<MovieModel>> fetchWatchNowMovies();
  Future<void> storeWatchNowMovies(List<MovieModel> movies);
}

class WatchNowMoviesLocalDataSourceimpl extends WatchNowMoviesLocalDataSource {
  @override
  Future<void> storeWatchNowMovies(List<MovieModel> movies) async {
    try {
      await SharedPrefs.setString(
          key: SharedPrefs.lastWatchNowMoviesList,
          value: jsonEncode(movies.map((movie) => movie.toJson()).toList()));
    } on CachException catch (e) {
      log("cache exception come from WatchNowMoviesLocalDataSourceimpl.storeWatchNowMovies and message is : ${e.errMessage} ");
      throw CachException(errMessage: e.errMessage);
    } catch (e) {
      log("general exception come from WatchNowMoviesLocalDataSourceimpl.storeWatchNowMovies and message is : ${e.toString()} ");

      throw CustomException(errMessage: e.toString());
    }
  }

  Future<List<MovieModel>> fetchWatchNowMovies() async {
    try {
      var movies =
          await SharedPrefs.getString(key: SharedPrefs.lastWatchNowMoviesList);
      List<MovieModel> moviesList = [];
      if (movies != null) {
        List<dynamic> moviesDecoded = jsonDecode(movies);
        for (var element in moviesDecoded) {
          moviesList.add(MovieModel.fromJson(element as Map<String, dynamic>));
        }
      } else {
        throw Exception("no internet connection ");
      }
      return moviesList;
    } on CachException catch (e) {
      log("cache exception come from WatchNowMoviesLocalDataSourceimpl.fetchWatchNowMovies and message is : ${e.errMessage} ");

      throw CachException(errMessage: e.errMessage);
    } catch (e) {
      log("general exception come from WatchNowMoviesLocalDataSourceimpl.fetchWatchNowMovies and message is : ${e.toString()} ");
      throw CustomException(errMessage: e.toString());
    }
  }
}
//  return jsonDecode(movies!)
//           .map((movie) => MovieModel.fromJson(movie))
//           .toList() as List<MovieModel>;
