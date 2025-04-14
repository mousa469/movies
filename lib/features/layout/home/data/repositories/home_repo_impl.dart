import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/core/services/network_checker.dart';
import 'package:movies/features/layout/home/data/datasources/add_movie_to_history_local_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/add_movie_to_history_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/add_movie_to_wish_list_local_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/add_movie_to_wish_list_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/availabe_movies_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/available_movies_local_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/fetch_similar_movies_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/movie_details_remote_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/watch_now_movies_local_data_source.dart';
import 'package:movies/features/layout/home/data/datasources/watch_now_movies_remote_data_source.dart';
import 'package:movies/features/layout/home/data/models/movie_details_model.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';
import 'package:movies/features/layout/home/domain/entities/movie_details_entity.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/repositories/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  AvailabeMoviesRemoteDataSource availabeMoviesRemoteDataSource;
  AvailableMoviesLocalDataSource availableMoviesLocalDataSource;
  WatchNowMoviesLocalDataSource watchNowMoviesLocalDataSource;
  WathchNowMoviesRemoteDataSource wathchNowMoviesRemoteDataSource;
  AddMovieToWishListLocalDataSource addMovieToWishListLocalDataSource;
  AddMovieToWishListRemoteDataSource addMovieToWishListRemoteDataSource;
  AddMovieToHistoryLocalDataSource addMovieToHistoryLocalDataSource;
  AddMovieToHistoryRemoteDataSource addMovieToHistoryRemoteDataSource;
  MovieDetailsRemoteDataSource movieDetailsRemoteDataSource;
  FetchSimilarMoviesRemoteDataSource fetchSimilarMoviesRemoteDataSource;
  ConnectivityService connectivityService;

  HomeRepoImpl(
      {required this.connectivityService,
      required this.fetchSimilarMoviesRemoteDataSource,
      required this.movieDetailsRemoteDataSource,
      required this.addMovieToHistoryLocalDataSource,
      required this.addMovieToHistoryRemoteDataSource,
      required this.addMovieToWishListLocalDataSource,
      required this.addMovieToWishListRemoteDataSource,
      required this.availabeMoviesRemoteDataSource,
      required this.availableMoviesLocalDataSource,
      required this.watchNowMoviesLocalDataSource,
      required this.wathchNowMoviesRemoteDataSource});
  @override
  Future<Either<Failure, List<MovieEntity>>> fetchAvailableMovies() async {
    bool hasInternetConnection =
        await connectivityService.hasInternetConnection();

    log(" internet connection :  $hasInternetConnection");

    try {
      if (hasInternetConnection) {
        List<MovieModel> movies =
            await availabeMoviesRemoteDataSource.fetchAvailableMovies();

        await availableMoviesLocalDataSource.cacheLastAvailableMovies(
            movies: movies);
        return right(movies.map<MovieEntity>((movie) => movie).toList());
      } else {
        List<MovieModel> movies =
            await availableMoviesLocalDataSource.fetchAvailableMovies();
        log("available movies fetched successfully : $movies");

        return right(movies);
      }
    } on DioCustomException catch (e) {
      log("exception from DioCustomException HomeRepoImpl.fetchAvailableMovies and message is : ${e.dioException.message} ");
      return left(DioFailure(errMessage: e.dioException.message.toString()));
    } on CacheException catch (e) {
      log("exception from CachException HomeRepoImpl.fetchAvailableMovies and message is : ${e.errMessage} ");

      return left(
        CacheFailure(
          errMessage: e.errMessage,
        ),
      );
    } on CustomException catch (e) {
      log("exception from custom  exception HomeRepoImpl.fetchAvailableMovies and message is : ${e.toString()} ");
      return left(Failure(errMessage: e.errMessage));
    } catch (e) {
      log("exception from general exception HomeRepoImpl.fetchAvailableMovies and message is : ${e.toString()} ");

      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> fetchWatchNowMovies() async {
    bool hasInternetConnection =
        await connectivityService.hasInternetConnection();
    // bool hasInternetConnection = true;
    log("internet connection : $hasInternetConnection");

    try {
      if (hasInternetConnection) {
        List<MovieModel> movies =
            await wathchNowMoviesRemoteDataSource.fetchWatchNowMovies();

        watchNowMoviesLocalDataSource.storeWatchNowMovies(movies: movies);
        return right(movies.map<MovieEntity>((movie) => movie).toList());
      } else {
        List<MovieModel> movies =
            await watchNowMoviesLocalDataSource.fetchWatchNowMovies();
        log("watch now movies fetched successfully : $movies");
        return right(movies.map<MovieEntity>((movie) => movie).toList());
      }
    } on DioCustomException catch (e) {
      log("exception from DioCustomException HomeRepoImpl.fetchAvailableMovies and message is : ${e.dioException.message} ");
      return left(DioFailure(errMessage: e.dioException.message.toString()));
    } on CacheException catch (e) {
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
Future<Either<Failure, void>> addMovieToWishList(
    {required MovieEntity movie}) async {
  try {
    bool hasInternetConnection =
        await connectivityService.hasInternetConnection();
    
    ServerException? serverException;

    if (hasInternetConnection) {
      try {
        await addMovieToWishListRemoteDataSource.addMovieToWishList(movie: movie);
      } on ServerException catch (e) {
        if (e.errMessage == "Movie is already exist in the wishlist") {
          log("Movie already exists, skipping remote but adding locally.");
          serverException = e; // Store the exception to return it later
        } else {
          log("Remote exception: ${e.errMessage}");
          rethrow; // Other errors should still be thrown
        }
      }
    }

    await addMovieToWishListLocalDataSource.addMovieToWishList(movie: movie);

    // If we caught the "already exists" exception, return it to the UI
    if (serverException != null) {
      return Left(ServerFailure(errMessage: serverException.errMessage));
    }

    return Right(null);
  } on CacheException catch (e) {
    log("Cache exception: ${e.errMessage}");
    return Left(CacheFailure(errMessage: e.errMessage));
  } on ServerException catch (e) {
    log("Server exception: ${e.errMessage}");
    return Left(ServerFailure(errMessage: e.errMessage));
  } catch (e) {
    log("General exception: ${e.toString()}");
    return Left(Failure(errMessage: e.toString()));
  }
}

  @override
  Future<Either<Failure, void>> addMovieToHistory(
      {required MovieEntity movie}) async {
    try {
      bool hasInternetConnection =
          await connectivityService.hasInternetConnection();
      if (hasInternetConnection) {
        await addMovieToHistoryRemoteDataSource.addMovieToHistory(movie: movie);
      } else {
        addMovieToHistoryLocalDataSource.addMovieToHistory(movie: movie);
      }
      return Right(null);
    } on CacheException catch (e) {
      log("cache exception return from HomeRepoImpl.addMovieToWishList and message is : ${e.errMessage}  ");
      return left(CacheFailure(errMessage: e.errMessage));
    } on ServerException catch (e) {
      log("server exception return from HomeRepoImpl.addMovieToWishList and message is : ${e.errMessage}  ");

      return Left(ServerFailure(errMessage: e.errMessage));
    } catch (e) {
      log("general exception return from HomeRepoImpl.addMovieToWishList and message is : ${e.toString()}  ");

      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieDetailsEntity>> fetchMovieDetails(
      {required int movieID}) async {
    try {
      bool hasInternetConnection =
          await connectivityService.hasInternetConnection();

      if (hasInternetConnection) {
        MovieDetailsModel movieDetailsModel = await movieDetailsRemoteDataSource
            .fetchMovieDetails(movieID: movieID);
        return Right(movieDetailsModel);
      } else {
        return Left(Failure(
            errMessage: "No internet Connection , please check your network"));
      }
    } on DioCustomException catch (e) {
      return Left(DioFailure.fromDio(e.dioException));
    } on CacheException catch (e) {
      log("cache exception return from HomeRepoImpl.addMovieToWishList and message is : ${e.errMessage}  ");
      return left(CacheFailure(errMessage: e.errMessage));
    } on ServerException catch (e) {
      log("server exception return from HomeRepoImpl.addMovieToWishList and message is : ${e.errMessage}  ");

      return Left(ServerFailure(errMessage: e.errMessage));
    } catch (e) {
      log("general exception return from HomeRepoImpl.addMovieToWishList and message is : ${e.toString()}  ");

      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> fetchSimilarMovies(
      {required int id}) async {
    try {
      List<MovieModel> movies =
          await fetchSimilarMoviesRemoteDataSource.fetchSimilarMovies(id: id);
      return Right(movies);
    } on DioCustomException catch (e) {
      return Left(DioFailure.fromDio(e.dioException));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
