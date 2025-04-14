import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class FetchListOfMoviesInHistoryLocalDataSource {
  Future<List<MovieModel>> fetchListOfMoviesInHistory();
  Future<void> storeListOfMoviesInHistory({required List<MovieModel> movies});
}

class FetchListOfMoviesInHistoryLocalDataSourceImpl
    extends FetchListOfMoviesInHistoryLocalDataSource {
  final LocalStorage localStorage;

  FetchListOfMoviesInHistoryLocalDataSourceImpl({required this.localStorage});

  @override
  Future<List<MovieModel>> fetchListOfMoviesInHistory() async {
    try {
      List<MovieModel>? movies =
          localStorage.getList<MovieModel>(key: LocalStorage.history);
      if (movies != null && movies.isNotEmpty) {
        return movies;
      } else {
        return [];
      }
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  Future<void> storeListOfMoviesInHistory(
      {required List<MovieModel> movies}) async {
    try {
      localStorage.setList<MovieModel>(
          key: LocalStorage.history, value: movies);
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }
}
