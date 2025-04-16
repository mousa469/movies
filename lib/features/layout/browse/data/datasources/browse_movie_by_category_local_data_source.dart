import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class BrowseMovieByCategoryLocalDataSource {
  List<MovieModel> browseMovieByCategory({required String category});
  void setBrowseMovieByCategory({required List<MovieModel> movies});
}

class BrowseMovieByCategoryLocalDataSourceImpl
    implements BrowseMovieByCategoryLocalDataSource {
  LocalStorage localStorage;
  BrowseMovieByCategoryLocalDataSourceImpl({required this.localStorage});
  @override
  List<MovieModel> browseMovieByCategory({required String category}) {
    try {
      List<MovieModel> movies =
          localStorage.getList<MovieModel>(key: LocalStorage.movieCategory) ??
              [];
      return movies;
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  void setBrowseMovieByCategory({required List<MovieModel> movies}) {
    try {
      localStorage.setList<MovieModel>(
          key: LocalStorage.movieCategory, value: movies);
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }
}
