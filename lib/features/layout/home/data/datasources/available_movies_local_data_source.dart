import 'dart:developer';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class AvailableMoviesLocalDataSource {
  Future<void> cacheLastAvailableMovies({required List<MovieModel> movies});
  Future<List<MovieModel>> fetchAvailableMovies();
}

class AvailableMoviesLocalDataSourceImpl
    extends AvailableMoviesLocalDataSource {
  final LocalStorage localStorage;

  AvailableMoviesLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> cacheLastAvailableMovies(
      {required List<MovieModel> movies}) async {
    try {
      if (movies.isNotEmpty) {
        List<MovieModel>? oldListOfMovies = localStorage.getList<MovieModel>(
            key: LocalStorage.lastAvailableMoviesList);

        if (!checkEqulity(oldList: oldListOfMovies, newList: movies)) {
          localStorage.setList<MovieModel>(
              key: LocalStorage.lastAvailableMoviesList, value: movies);
        } else {
          log("oldListOfMovies is null || old list of movies equal new list of movies ");
        }
      } else {
        log(" ----------- No Movies available to cache, list is empty --------------------");
      }
    } catch (e) {
      log(" --------------- Error in cacheLastAvailableMovies: ${e.toString()} ----------------");
    }
  }

  @override
  Future<List<MovieModel>> fetchAvailableMovies() async {
    try {
      List<MovieModel>? listOfMovies =
          localStorage.getList(key: LocalStorage.lastAvailableMoviesList);

      if (listOfMovies != null && listOfMovies.isNotEmpty) {
        log("--------------- Movies are not empty and returned successfully ---------------");
        return listOfMovies;
      } else {
        log(" --------------- No movies available in cache. Likely the first time opening the app with no internet. ---------------");
        throw CacheException(
            errMessage: "No internet connection, please check your network.");
      }
    } catch (e) {
      log(" --------------- Error in fetchAvailableMovies: ${e.toString()} --------------- ");
      throw Exception("Error fetching available movies: ${e.toString()}");
    }
  }

  bool checkEqulity(
      {required List<MovieModel>? oldList, required List<MovieModel> newList}) {
    if (oldList == null) {
      return false;
    }

    if (oldList.length != newList.length) {
      return false;
    }
    for (int i = 0; i < oldList.length; i++) {
      if (oldList[i].id != newList[i].id) {
        return false;
      }
    }

    return true;
  }
}
