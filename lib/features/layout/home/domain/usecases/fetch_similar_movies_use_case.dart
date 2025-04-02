import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/repositories/home_repo.dart';

class FetchSimilarMoviesUseCase {
  HomeRepo homeRepo;
  FetchSimilarMoviesUseCase({required this.homeRepo});
  Future<Either<Failure, List<MovieEntity>>> call({required int id}) async {
    return await homeRepo.fetchSimilarMovies(id: id);
  }
}
