import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/home/domain/entities/movie_details_entity.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<MovieEntity>>> fetchAvailableMovies();
  Future<Either<Failure, List<MovieEntity>>> fetchWatchNowMovies();
  Future<Either<Failure, List<MovieEntity>>> fetchSimilarMovies({required int id});
  Future<Either<Failure,void>> addMovieToWishList({required MovieEntity movie});
  Future<Either<Failure,void>> addMovieToHistory({required MovieEntity movie});
  Future<Either<Failure,MovieDetailsEntity>> fetchMovieDetails({required int movieID});
}
  