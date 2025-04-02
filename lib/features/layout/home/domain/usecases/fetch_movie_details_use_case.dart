import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/home/domain/entities/movie_details_entity.dart';
import 'package:movies/features/layout/home/domain/repositories/home_repo.dart';

class FetchMovieDetailsUseCase {
  HomeRepo homeRepo;
  FetchMovieDetailsUseCase({required this.homeRepo});
  Future<Either<Failure, MovieDetailsEntity>> call(
      {required int movieID}) async {
    try {
      final result = await homeRepo.fetchMovieDetails(movieID: movieID);
      return result;
    } catch (e) {
      print("Error in FetchMovieDetailsUseCase: $e");
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
