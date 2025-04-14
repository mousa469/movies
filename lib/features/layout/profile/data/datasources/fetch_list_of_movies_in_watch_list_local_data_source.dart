import 'dart:developer';

import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

abstract class FetchListOfMoviesInWatchListLocalDataSource {
  List<MovieEntity> fetchListOfMoviesInWatchList();
}

class FetchListOfMoviesInWatchListLocalDataSourceImpl
    implements FetchListOfMoviesInWatchListLocalDataSource {
  LocalStorage localStorage;

  FetchListOfMoviesInWatchListLocalDataSourceImpl({required this.localStorage});
  @override
  List<MovieEntity> fetchListOfMoviesInWatchList() {
    try {
      var movies = localStorage.getList<MovieEntity>(
          key: LocalStorage.wishList);
      if (movies != null && movies.isNotEmpty) {
        log("movies are not empty and returned successfully");
        return movies;
      } else {
        log("movies are empty");
        return [];
      }
    } catch (e) {
      log("general exception from FetchListOfMoviesInWatchListLocalDataSourceImpl.fetchListOfMoviesInWatchList and message is : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
  
}
