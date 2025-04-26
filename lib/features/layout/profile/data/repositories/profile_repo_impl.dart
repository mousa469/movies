import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/core/services/network_checker.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/profile/data/datasources/profile_local_data_source.dart';
import 'package:movies/features/layout/profile/data/datasources/profile_remote_data_source.dart';
import 'package:movies/features/layout/profile/data/models/user_profile_model.dart';
import 'package:movies/features/layout/profile/domain/entities/user_profile_entity.dart';
import 'package:movies/features/layout/profile/domain/repositories/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {

ConnectivityService connectivityService;
ProfileLocalDataSource  profileLocalDataSource;
  ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl({
  required this.profileRemoteDataSource,
    required this.profileLocalDataSource,
    required this.connectivityService,
  });

  @override
  Future<Either<Failure, int>> fetchNumberOfMoviesInHistory() async {
    try {
      bool hasInternetConnection =
          await connectivityService.hasInternetConnection();

      if (hasInternetConnection) {
        int numberOfMovies = await profileRemoteDataSource
            .fetchNumberOfMoviesInHistory();
        profileLocalDataSource.storeNumberOfMoviesInHistory(
            numberOfMovies: numberOfMovies);
        return Right(numberOfMovies);
      } else {
        return Right(profileLocalDataSource
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
            await profileRemoteDataSource
                .fetchNumberOfMoviesInWatchList();
        profileLocalDataSource.storeNumberOfMoviesInWatchList(
            numberOfMovies: numberOfMovies);
        return Right(numberOfMovies);
      } else {
        return Right(profileLocalDataSource
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
            await profileRemoteDataSource.fetchUserData();

        profileLocalDataSource.storeUserData(user: userProfile);

        return Right(userProfile);
      } else {
        return Right(profileLocalDataSource.fetchUserData());
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
      await profileRemoteDataSource.updateUserData(
        userName: userName,
        userPhone: userPhone,
      );

      profileLocalDataSource.updateUserData(
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
            await profileRemoteDataSource
                .fetchListOfMoviesInHistory();
        profileLocalDataSource.storeListOfMoviesInHistory(
            movies: movies);
        return Right(movies);
      } else {
        List<MovieModel> movies =
            await profileLocalDataSource
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
            await profileRemoteDataSource
                .fetchListOfMoviesInWatchList();
        return Right(movies);
      } else {
        List<MovieEntity> movies = profileLocalDataSource
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
        return Right(await profileRemoteDataSource.logOut());
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
