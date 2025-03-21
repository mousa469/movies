import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/home/domain/repositories/home_repo.dart';

class AddMovieToWishListUseCase {
  HomeRepo homeRepo;
  AddMovieToWishListUseCase({required this.homeRepo});

  Future<Either<Failure, void>> call({required MovieEntity movie }) {
   return  homeRepo.addMovieToWishList(movie: movie);
  }
}
