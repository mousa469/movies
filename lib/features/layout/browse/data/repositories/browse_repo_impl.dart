import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/core/services/network_checker.dart';
import 'package:movies/features/layout/browse/data/datasources/browse_movie_by_category_local_data_source.dart';
import 'package:movies/features/layout/browse/data/datasources/browse_movie_by_category_remote_data_source.dart';
import 'package:movies/features/layout/browse/domain/repositories/browse_repo.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

class BrowseRepoImpl implements BrowseRepo {
  BrowseMovieByCategoryRemoteDataSource browseMovieByCategoryRemoteDataSource;
  BrowseMovieByCategoryLocalDataSource browseMovieByCategoryLocalDataSource;
  ConnectivityService connectivityService;

  BrowseRepoImpl(
      {required this.connectivityService,
      required this.browseMovieByCategoryRemoteDataSource,
      required this.browseMovieByCategoryLocalDataSource});
  @override
  Future<Either<Failure, List<MovieEntity>>> browseMovieByCategory(
      {required String category}) async {
    try {
      bool hasInternetConnection =
          await connectivityService.hasInternetConnection();

      if (hasInternetConnection) {
        List<MovieModel> movies = await browseMovieByCategoryRemoteDataSource
            .browseMovieByCategory(category: category);
        browseMovieByCategoryLocalDataSource.setBrowseMovieByCategory(
            movies: movies);
        return Right(movies);
      } else {
        List<MovieModel> movies = await browseMovieByCategoryLocalDataSource
            .browseMovieByCategory(category: category);
        return Right(movies);
      }
    } on DioCustomException catch (e) {
      return Left(DioFailure(errMessage: e.dioException.message.toString()));
    } on CacheException catch (e) {
      return Left(CacheFailure(errMessage: e.errMessage.toString()));
    }
  }
}
