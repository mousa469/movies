import 'dart:developer';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

abstract class AddMovieToHistoryLocalDataSource {
  void addMovieToHistory({required MovieEntity movie});
  List<MovieEntity> fetchMoviesFromHistory();
}

class AddMovieToHistoryLocalDataSourceImpl
    extends AddMovieToHistoryLocalDataSource {
  final LocalStorage localStorage;

  AddMovieToHistoryLocalDataSourceImpl({required this.localStorage});

  @override
  void addMovieToHistory({required MovieEntity movie}) {
    try {
      List<MovieEntity>? oldMovieList =
          localStorage.getList<MovieEntity>(key: LocalStorage.history);

      if (oldMovieList != null && oldMovieList.isNotEmpty) {
        if (!checkIfMovieExist(movie: movie, movies: oldMovieList)) {
          oldMovieList.add(movie);
          localStorage.setList<MovieEntity>(
              key: LocalStorage.history, value: oldMovieList);
        }
      } else {
        log("No movies cached before in the history list");
        localStorage.setList<MovieEntity>(
            key: LocalStorage.history, value: [movie]);
      }
    } catch (e) {
      log("Exception in addMovieToHistory: \${e.toString()}");
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  List<MovieEntity> fetchMoviesFromHistory() {
    try {
      List<MovieEntity>? movies =
          localStorage.getList<MovieEntity>(key: LocalStorage.history);
      if (movies != null && movies.isNotEmpty) {
        return movies;
      } else {
        log("No movies found in history");
        return [];
      }
    } catch (e) {
      log("Exception in fetchMoviesFromHistory: \${e.toString()}");
      throw CacheException(errMessage: e.toString());
    }
  }

  bool checkIfMovieExist(
      {required MovieEntity movie, required List<MovieEntity> movies}) {
    for (int i = 0; i < movies.length; i++) {
      if (movie.id == movies[i].id) {
        return true;
      }
    }
    return false;
  }
}

// import 'dart:developer';
// import 'package:movies/core/services/custom_exception.dart';
// import 'package:movies/core/services/local_storage/local_storage.dart';
// import 'package:movies/features/layout/home/domain/entities/movie_details_entity.dart';
// import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

// abstract class AddMovieToHistoryLocalDataSource {
//   void addMovieToHistory({required MovieDetailsEntity movie});
// }

// class AddMovieToHistoryLocalDataSourceImpl
//     extends AddMovieToHistoryLocalDataSource {
//   final LocalStorage localStorage;

//   AddMovieToHistoryLocalDataSourceImpl({required this.localStorage});

//   @override
//   void addMovieToHistory({required MovieDetailsEntity movie}) {
//     try {
//       // Retrieve the existing history (list of movies)
//       List<MovieDetailsEntity> history =
//           (localStorage.getObject(key: LocalStorage.history) as List<dynamic>?)
//                   ?.map((json) => MovieDetailsEntity.fromJson(json: json))
//                   .toList() ??
//               [];

//       // Check if the movie is already in the history
//       bool alreadyExists = history.any((m) => m.id == movie.id);

//       if (!alreadyExists) {
//         history.add(movie);
//         // Store the updated history
//         localStorage.setObject(
//             key: LocalStorage.history,
//             value: history.map((m) => m.toJson()).toList());
//         log("Movie added to history successfully.");
//       } else {
//         log("Movie already exists in the history.");
//       }
//     } catch (e) {
//       log("Exception in addMovieToHistory: ${e.toString()}");
//       throw CacheException(errMessage: e.toString());
//     }
//   }
// }
