import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/core/services/network_checker.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_list_of_movies_in_history.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_list_of_movies_in_history_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_list_of_movies_in_watch_list_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_list_of_movies_in_watch_list_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_number_of_movies_in_history_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_number_of_movies_in_watch_list_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_user_data_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/fetch_user_data_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/log_out_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/number_of_movies_in_history_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/number_of_movies_of_watch_list.dart';
import 'package:movies/features/layout/profile/data/datasources/update_user_data_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/update_user_data_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/models/user_profile_model.dart';
import 'package:movies/features/layout/profile/domain/entities/user_profile_entity.dart';
import 'package:movies/features/layout/profile/domain/repositories/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  LogOutDataSource logOutDataSource;
  UpdateUserDataLocalDataSource updateUserDataLocalDataSource;
  UpdateUserDataRemoteDataSource updateUserDataRemoteDataSource;
  FetchNumberOfMoviesInHistoryRemoteDataSource
      fetchNumberOfMoviesInHistoryRemoteDataSource;
  NumberOfMoviesInHistoryLocalDataSource numberOfMoviesInHistoryLocalDataSource;
  FetchNumberOfMoviesInWatchListRemoteDataSource
      fetchNumberOfMoviesInWatchListRemoteDataSource;
  NumberOfMoviesInWatchListLocalDataSource
      numberOfMoviesInWatchListLocalDataSource;
  ConnectivityService connectivityService;
  FetchUserDataRemoteDataSource fetchUserDataRemoteDataSource;
  UserDataLocalDataSource userDataLocalDataSource;
  FetchListOfMoviesInHistoryRemoteDataSource
      fetchListOfMoviesInHistoryRemoteDataSource;
  FetchListOfMoviesInHistoryLocalDataSource
      fetchListOfMoviesInHistoryLocalDataSource;
  FetchListOfMoviesInWatchListRemoteDataSource
      fetchListOfMoviesInWatchListRemoteDataSource;
  FetchListOfMoviesInWatchListLocalDataSource
      fetchListOfMoviesInWatchListLocalDataSource;

  ProfileRepoImpl({
    required this.logOutDataSource,
    required this.fetchListOfMoviesInWatchListRemoteDataSource,
    required this.fetchListOfMoviesInWatchListLocalDataSource,
    required this.fetchListOfMoviesInHistoryRemoteDataSource,
    required this.fetchListOfMoviesInHistoryLocalDataSource,
    required this.updateUserDataLocalDataSource,
    required this.updateUserDataRemoteDataSource,
    required this.fetchUserDataRemoteDataSource,
    required this.userDataLocalDataSource,
    required this.numberOfMoviesInWatchListLocalDataSource,
    required this.fetchNumberOfMoviesInWatchListRemoteDataSource,
    required this.connectivityService,
    required this.fetchNumberOfMoviesInHistoryRemoteDataSource,
    required this.numberOfMoviesInHistoryLocalDataSource,
  });

  @override
  Future<Either<Failure, int>> fetchNumberOfMoviesInHistory() async {
    try {
      bool hasInternetConnection =
          await connectivityService.hasInternetConnection();

      if (hasInternetConnection) {
        int numberOfMovies = await fetchNumberOfMoviesInHistoryRemoteDataSource
            .fetchNumberOfMoviesInHistory();
        numberOfMoviesInHistoryLocalDataSource.storeNumberOfMoviesInHistory(
            numberOfMovies: numberOfMovies);
        return Right(numberOfMovies);
      } else {
        return Right(numberOfMoviesInHistoryLocalDataSource
            .fetchNumberOfMoviesInHistory());
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(errMessage: e.errMessage));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(errMessage: e.message!));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> fetchNumberOfMoviesInWatchList() async {
    try {
      bool hasInternetConnection =
          await connectivityService.hasInternetConnection();

      if (hasInternetConnection) {
        int numberOfMovies =
            await fetchNumberOfMoviesInWatchListRemoteDataSource
                .fetchNumberOfMoviesInWatchList();
        numberOfMoviesInWatchListLocalDataSource.storeNumberOfMoviesInWatchList(
            numberOfMovies: numberOfMovies);
        return Right(numberOfMovies);
      } else {
        return Right(numberOfMoviesInWatchListLocalDataSource
            .fetchNumberOfMoviesInWatchList());
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(errMessage: e.errMessage));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(errMessage: e.message!));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> fetchUserData() async {
    try {
      bool hasInternetConnection =
          await connectivityService.hasInternetConnection();

      if (hasInternetConnection) {
        UserProfileModel userProfile =
            await fetchUserDataRemoteDataSource.fetchUserData();

        userDataLocalDataSource.storeUserData(user: userProfile);

        return Right(userProfile);
      } else {
        return Right(userDataLocalDataSource.fetchUserData());
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(errMessage: e.errMessage));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(errMessage: e.message!));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserData(
      {String? userName, String? userPhone}) async {
    try {
      await updateUserDataRemoteDataSource.updateUserData(
        userName: userName,
        userPhone: userPhone,
      );

      updateUserDataLocalDataSource.updateUserData(
        userName: userName,
        userPhone: userPhone,
      );

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(errMessage: e.errMessage));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(errMessage: e.message ?? 'Firebase error'));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>>
      fetchListOfMoviesInHistory() async {
    try {
      bool hasInternetConnection =
          await connectivityService.hasInternetConnection();
      if (hasInternetConnection) {
        List<MovieModel> movies =
            await fetchListOfMoviesInHistoryRemoteDataSource
                .fetchListOfMoviesInHistory();
        fetchListOfMoviesInHistoryLocalDataSource.storeListOfMoviesInHistory(
            movies: movies);
        return Right(movies);
      } else {
        List<MovieModel> movies =
            await fetchListOfMoviesInHistoryLocalDataSource
                .fetchListOfMoviesInHistory();
        return Right(movies);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(errMessage: e.errMessage));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(errMessage: e.message ?? 'Firebase error'));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>>
      fetchListOfMoviesInWatchList() async {
    try {
      bool hasInternetConnection =
          await connectivityService.hasInternetConnection();
      if (hasInternetConnection) {
        List<MovieModel> movies =
            await fetchListOfMoviesInWatchListRemoteDataSource
                .fetchListOfMoviesInWatchList();
        return Right(movies);
      } else {
        List<MovieEntity> movies = fetchListOfMoviesInWatchListLocalDataSource
            .fetchListOfMoviesInWatchList();
        return Right(movies);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(errMessage: e.errMessage));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(errMessage: e.message ?? 'Firebase error'));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      bool hasInternetConnection =
          await connectivityService.hasInternetConnection();

      if (hasInternetConnection) {
        return Right(await logOutDataSource.logOut());
      } else {
        return Left(Failure(errMessage: 'No internet connection'));
      }
    } on FirebaseException catch (e) {
      return Left(ServerFailure(errMessage: e.message ?? 'Firebase error'));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
