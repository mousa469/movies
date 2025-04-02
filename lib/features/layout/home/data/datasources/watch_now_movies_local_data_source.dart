import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class WatchNowMoviesLocalDataSource {
  Future<void> storeWatchNowMovies({required List<MovieModel> movies});
  Future<List<MovieModel>> fetchWatchNowMovies();
}

class WatchNowMoviesLocalDataSourceImpl
    extends WatchNowMoviesLocalDataSource {
  final LocalStorage localStorage;

  WatchNowMoviesLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> storeWatchNowMovies({required List<MovieModel> movies}) async {
    try {
      if (movies.isNotEmpty) {
        List<MovieModel>? oldMoviesList = localStorage.getList<MovieModel>(
            key: LocalStorage.lastWatchNowMoviesList);

        if (!checkEquality(oldList: oldMoviesList, newList: movies)) {
          localStorage.setList<MovieModel>(
              key: LocalStorage.lastWatchNowMoviesList, value: movies);
        } else {
          log("oldMoviesList is null || old movies list equals new movies list");
        }
      } else {
        log(" ----------- No Movies available to store, list is empty --------------------");
      }
    } catch (e) {
      log(" --------------- Error in storeWatchNowMovies: \${e.toString()} ----------------");
    }
  }

  @override
  Future<List<MovieModel>> fetchWatchNowMovies() async {
    try {
      List<MovieModel>? watchNowMovies = localStorage.getList(
          key: LocalStorage.lastWatchNowMoviesList)!;

      if (watchNowMovies.isNotEmpty) {
        log("--------------- Movies are not empty and returned successfully ---------------");
        return watchNowMovies;
      } else {
        log(" --------------- No movies available in cache. Likely the first time opening the app with no internet. ---------------");
        throw CacheException(
            errMessage: "No internet connection, please check your network.");
      }
    } catch (e) {
      log(" --------------- Error in fetchWatchNowMovies: \${e.toString()} --------------- ");
      throw Exception("Error fetching watch now movies: \${e.toString()}");
    }
  }

  bool checkEquality(
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
