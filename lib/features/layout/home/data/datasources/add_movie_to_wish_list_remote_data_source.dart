import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

abstract class AddMovieToWishListRemoteDataSource {
  Future<void> addMovieToWishList({required MovieEntity movie});
}

class AddMovieToWishListRemoteDataSourceimpl
    extends AddMovieToWishListRemoteDataSource {
  LocalStorage localStorage;
  DatabaseServices databaseServices;
  AddMovieToWishListRemoteDataSourceimpl({required this.databaseServices ,required this.localStorage});
  @override
  Future<void> addMovieToWishList({required MovieEntity movie}) async {
    bool isExisted = await databaseServices.checkIfDataExist(
        path: EndPoints.users,
        id: localStorage.getString(key: LocalStorage.userID)!,
        subCollectionID: movie.id.toString(),
        subCollectionName: EndPoints.movies);

    if (!isExisted) {
      await databaseServices.storeData(
        subCollectionID: movie.id.toString(),
        path: EndPoints.users,
        data: movie.toJson(),
        id: localStorage.getString(key: LocalStorage.userID),
        subCollectionName: EndPoints.movies,
      );
    } else {
      throw ServerException(
          errMessage: "Movie is already exist in the wishlist");
    }
  }
}
