import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/repositories/home_repo.dart';

class AddMovieToHistoryUseCase {
  HomeRepo homeRepo;
  AddMovieToHistoryUseCase({required this.homeRepo});
  Future<Either<Failure, void>> call({required MovieEntity movie}) {
    return homeRepo.addMovieToHistory(movie: movie);
  }
}
