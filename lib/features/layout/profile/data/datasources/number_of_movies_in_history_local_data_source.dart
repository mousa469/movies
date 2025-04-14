import 'dart:developer';

import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';

abstract class NumberOfMoviesInHistoryLocalDataSource {
  int fetchNumberOfMoviesInHistory();
  void storeNumberOfMoviesInHistory({required int numberOfMovies});
}

class NumberOfMoviesInHistoryLocalDataSourceImpl
    implements NumberOfMoviesInHistoryLocalDataSource {
  LocalStorage localStorage;
  NumberOfMoviesInHistoryLocalDataSourceImpl({required this.localStorage});
  @override
  int fetchNumberOfMoviesInHistory() {
    try {
      int? moviesNumber =
          localStorage.getInt(key: LocalStorage.numberOfHistoryMovies);
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
  void storeNumberOfMoviesInHistory({required int numberOfMovies}) {
    localStorage.setInt(
        key: LocalStorage.numberOfHistoryMovies, value: numberOfMovies);
  }
}
