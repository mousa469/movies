import 'dart:developer';

import 'package:movies/core/services/api_services.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class WathchNowMoviesRemoteDataSource {
  Future<List<MovieModel>> fetchWatchNowMovies();
}

class WathchNowMoviesRemoteDataSourceimpl
    extends WathchNowMoviesRemoteDataSource {
  ApiService apiService;

  WathchNowMoviesRemoteDataSourceimpl({required this.apiService});
  @override
  Future<List<MovieModel>> fetchWatchNowMovies() async {
    try {
      List<MovieModel> moviesModelList = [];
      var movies = await apiService.get(EndPoints.watchNow);
      for (var movie in movies.data["data"]["movies"]) {
        moviesModelList.add(MovieModel.fromJson(movie));
      }
      return moviesModelList;
    } on DioCustomException catch (e) {
      log("exception come from WathchNowMoviesRemoteDataSourceimpl.fetchWatchNowMovies amd message is : ${e.dioException.error}");
      throw DioCustomException(dioException: e.dioException);
    } on CustomException catch (e) {
      log("exception come from general exception WathchNowMoviesRemoteDataSourceimpl.fetchWatchNowMovies amd message is : ${e.toString()}");
      throw CustomException(errMessage: e.toString());
    }
  }
}
