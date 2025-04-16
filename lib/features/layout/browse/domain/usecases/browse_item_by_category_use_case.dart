import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/browse/domain/repositories/browse_repo.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

class BrowseMovieByCategoryUseCase {
  BrowseRepo repo;
  BrowseMovieByCategoryUseCase({required this.repo});
  Future<Either<Failure, List<MovieEntity>>> call({required String category}) {
    return repo.browseMovieByCategory(category: category);
  }
}
