import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/repositories/home_repo.dart';

class FetchAvailableMoviesUseCase {
  HomeRepo homeRepo;

  FetchAvailableMoviesUseCase({required this.homeRepo});

  Future<Either<Failure, List<MovieEntity>>> call() {
    return homeRepo.fetchAvailableMovies();
  }
}
