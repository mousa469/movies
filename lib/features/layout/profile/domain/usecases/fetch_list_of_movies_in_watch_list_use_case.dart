import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/profile/domain/repositories/profile_repo.dart';

class FetchListOfMoviesInWatchListUseCase {
  ProfileRepo profileRepo;
  FetchListOfMoviesInWatchListUseCase({required this.profileRepo});
  Future<Either<Failure, List<MovieEntity>>> call() async {
    return await profileRepo.fetchListOfMoviesInWatchList();
  }
}
