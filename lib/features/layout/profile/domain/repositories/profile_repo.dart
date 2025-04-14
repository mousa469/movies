import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/profile/domain/entities/user_profile_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failure, int>> fetchNumberOfMoviesInHistory();
  Future<Either<Failure, int>> fetchNumberOfMoviesInWatchList();
  Future<Either<Failure, UserProfileEntity>> fetchUserData();
  Future<Either<Failure, void>> updateUserData(
      {String? userName, String? userPhone});
  Future<Either<Failure, List<MovieEntity>>> fetchListOfMoviesInHistory();
  Future<Either<Failure, List<MovieEntity>>> fetchListOfMoviesInWatchList();
  Future<Either<Failure, void>> logOut();
}
