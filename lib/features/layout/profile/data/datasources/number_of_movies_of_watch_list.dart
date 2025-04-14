import 'dart:developer';

import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';

abstract class NumberOfMoviesInWatchListLocalDataSource {
  int fetchNumberOfMoviesInWatchList();
  void storeNumberOfMoviesInWatchList({required int numberOfMovies});
}

class NumberOfMoviesInWatchListLocalDataSourceImpl
    implements NumberOfMoviesInWatchListLocalDataSource {
  LocalStorage localStorage;
  NumberOfMoviesInWatchListLocalDataSourceImpl({required this.localStorage});
  @override
  int fetchNumberOfMoviesInWatchList() {
    try {
      int? moviesNumber =
          localStorage.getInt(key: LocalStorage.numberOfWatchListMovies);
      if (moviesNumber != null) {
        log("number of movies is = $moviesNumber");
        return moviesNumber;
      } else {
        return 0;
      }
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  void storeNumberOfMoviesInWatchList({required int numberOfMovies}) {
    localStorage.setInt(
        key: LocalStorage.numberOfWatchListMovies, value: numberOfMovies);
  }
}
