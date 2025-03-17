import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/core/services/network_checker.dart';
import 'package:movies/features/layout/home/data/datasources/availabe_movies_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/available_movies_local_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/watch_now_movies_local_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/watch_now_movies_remote_data_source.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/repositories/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  AvailabeMoviesRemoteDataSource availabeMoviesRemoteDataSource;
  AvailableMoviesLocalDataSource availableMoviesLocalDataSource;
  WatchNowMoviesLocalDataSource watchNowMoviesLocalDataSource;
  WathchNowMoviesRemoteDataSource wathchNowMoviesRemoteDataSource;
  HomeRepoImpl(
      {required this.availabeMoviesRemoteDataSource,
      required this.availableMoviesLocalDataSource,
      required this.watchNowMoviesLocalDataSource,
      required this.wathchNowMoviesRemoteDataSource});
  @override
  Future<Either<Failure, List<MovieEntity>>> fetchAvailableMovies() async {
    bool hasInternetConnection = await NetworkChecker.checkInternetConnection();
    log(" internet connection :  $hasInternetConnection");

    try {
      if (hasInternetConnection) {
        List<MovieModel> movies =
            await availabeMoviesRemoteDataSource.fetchAvailableMovies();

        availableMoviesLocalDataSource.cacheLastAvailableMovies(movies: movies);
        return right(movies.map<MovieEntity>((movie) => movie).toList());
      } else {
        List<MovieModel> movies =
            await availableMoviesLocalDataSource.fetchAvailableMovies();
        if (movies.isEmpty) {
          return Left(ServerFailure(errMessage: "no internet connection"));
        }
        return right(movies.map<MovieEntity>((movie) => movie).toList());
      }
    } on DioCustomException catch (e) {
      log("exception from DioCustomException HomeRepoImpl.fetchAvailableMovies and message is : ${e.dioException.message} ");
      return left(DioFailure(errMessage: e.dioException.message.toString()));
    } on CachException catch (e) {
      log("exception from CachException HomeRepoImpl.fetchAvailableMovies and message is : ${e.errMessage} ");

      return left(
        CacheFailure(
          errMessage: e.errMessage,
        ),
      );
    } catch (e) {
      log("exception from general exception HomeRepoImpl.fetchAvailableMovies and message is : ${e.toString()} ");

      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> fetchWatchNowMovies() async {
    bool hasInternetConnection = await NetworkChecker.checkInternetConnection();
    log("internet connection : $hasInternetConnection");

    try {
      if (hasInternetConnection) {
        List<MovieModel> movies =
            await wathchNowMoviesRemoteDataSource.fetchWatchNowMovies();

        watchNowMoviesLocalDataSource.storeWatchNowMovies(movies);
        return right(movies.map<MovieEntity>((movie) => movie).toList());
      } else {
        List<MovieModel> movies =
            await watchNowMoviesLocalDataSource.fetchWatchNowMovies();
        return right(movies.map<MovieEntity>((movie) => movie).toList());
      }
    } on DioCustomException catch (e) {
      log("exception from DioCustomException HomeRepoImpl.fetchAvailableMovies and message is : ${e.dioException.message} ");
      return left(DioFailure(errMessage: e.dioException.message.toString()));
    } on CachException catch (e) {
      log("exception from CachException HomeRepoImpl.fetchAvailableMovies and message is : ${e.errMessage} ");

      return left(
        CacheFailure(
          errMessage: e.errMessage,
        ),
      );
    } catch (e) {
      log("exception from general exception HomeRepoImpl.fetchAvailableMovies and message is : ${e.toString()} ");

      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
