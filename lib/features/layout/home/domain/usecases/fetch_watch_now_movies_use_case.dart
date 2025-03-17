import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/repositories/home_repo.dart';

class FetchWatchNowMoviesUseCase {
  HomeRepo homeRepo;

  FetchWatchNowMoviesUseCase({required this.homeRepo});

  Future<Either<Failure, List<MovieEntity>>> call( ) async {
   return await  homeRepo.fetchWatchNowMovies();
  }
}
