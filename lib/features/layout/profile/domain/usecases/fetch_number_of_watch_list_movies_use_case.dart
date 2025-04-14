import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/profile/domain/repositories/profile_repo.dart';

class FetchNumberOfWatchListMoviesUseCase {
  ProfileRepo profileRepo;
  FetchNumberOfWatchListMoviesUseCase({required this.profileRepo});
  Future<Either<Failure, int>> call() {
    return profileRepo.fetchNumberOfMoviesInWatchList();
  }
}
