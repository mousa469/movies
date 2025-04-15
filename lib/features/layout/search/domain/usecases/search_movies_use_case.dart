import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/search/domain/repositories/search_repo.dart';

class SearchMoviesUseCase {
  SearchRepo searchRepo;

  SearchMoviesUseCase({required this.searchRepo});
  Future<Either<Failure, List<MovieEntity>>> call({required String query}) {
    return searchRepo.search(query: query);
  }
}
