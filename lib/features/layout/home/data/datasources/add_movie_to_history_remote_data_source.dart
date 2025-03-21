import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/core/services/shared_prefs.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

abstract class AddMovieToHistoryRemoteDataSource {
  Future<void> addMovieToHistory({required MovieEntity movie });
}

class AddMovieToHistoryRemoteDataSourceImpl
    extends AddMovieToHistoryRemoteDataSource {
  DatabaseServices databaseServices;
  AddMovieToHistoryRemoteDataSourceImpl({required this.databaseServices});

  @override
  Future<void> addMovieToHistory({required MovieEntity movie }) async {
    bool isExisted = await databaseServices.checkIfDataExist(
        path: EndPoints.users,
        id: SharedPrefs.getString(key: SharedPrefs.userID)!,
        subCollectionID: movie.id.toString(),
        subCollectionName: EndPoints.history);

    if (!isExisted) {
      await databaseServices.storeData(
        subCollectionID: movie.id.toString(),
        path: EndPoints.users,
        data: movie.toJson(),
        id: SharedPrefs.getString(key: SharedPrefs.userID),
        subCollectionName: EndPoints.history,
      );
    } else {
      throw ServerException(
          errMessage: "Movie is already exist in the wishlist");
    }
  }
}
