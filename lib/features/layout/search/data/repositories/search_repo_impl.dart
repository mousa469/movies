import 'package:dartz/dartz.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/core/services/network_checker.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/search/data/datasources/search_movie_local_data_source.dart';
import 'package:movies/features/layout/search/data/datasources/search_movie_remote_data_source.dart';
import 'package:movies/features/layout/search/domain/repositories/search_repo.dart';

class SearchRepoImpl extends SearchRepo {
  SearchMovieRemoteDataSource searchMovieRemoteDataSource;
  SearchMovieLocalDataSource searchMovieLocalDataSource;
  ConnectivityService connectivityService;
  SearchRepoImpl(

      {
        required this.searchMovieLocalDataSource,
        required this.connectivityService,
      required this.searchMovieRemoteDataSource});
  @override
  Future<Either<Failure, List<MovieEntity>>> search(
      {required String query}) async {
    try {
      bool hasInternetConnection =
          await connectivityService.hasInternetConnection();

      if (hasInternetConnection) {
        List<MovieModel> movies =
            await searchMovieRemoteDataSource.fetchSearchMovies(query: query);
        searchMovieLocalDataSource.storeSearchedMovies(movies: movies);
        return Right(movies.map<MovieEntity>((movie) => movie).toList());
      } else {
        List<MovieModel> movies =
            searchMovieLocalDataSource.fetchSearchedMovies();
        return Right(movies.map<MovieEntity>((movie) => movie).toList());
      }
    } on DioCustomException catch (e) {
      return Left(DioFailure(errMessage: e.dioException.message.toString()));
    } on CacheException catch (e) {
      return Left(CacheFailure(errMessage: e.errMessage.toString()));
    }
  }
}
