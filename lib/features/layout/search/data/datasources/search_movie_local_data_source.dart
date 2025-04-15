
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class SearchMovieLocalDataSource {
  Future<void> storeSearchedMovies({required List<MovieModel> movies});
  List<MovieModel> fetchSearchedMovies();
}

class SearchMovieLocalDataSourceImpl implements SearchMovieLocalDataSource {
  LocalStorage localStorage;

  SearchMovieLocalDataSourceImpl({required this.localStorage});
  @override
  Future<void> storeSearchedMovies({required List<MovieModel> movies}) {
    try {
      return localStorage.setList<MovieModel>(
          key: LocalStorage.searchedMovies, value: movies);
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  List<MovieModel> fetchSearchedMovies() {
    try {
      List<MovieModel>? movies =
          localStorage.getList<MovieModel>(key: LocalStorage.searchedMovies);
      if (movies != null && movies.isNotEmpty) {
        return movies;
      } else {
        return [];
      }
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }
}
