import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

abstract class BrowseRepo {
  Future<Either<Failure, List<MovieEntity>>> browseMovieByCategory({required String category});
}
