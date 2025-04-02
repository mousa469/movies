import 'package:dio/dio.dart';
import 'package:movies/core/services/api_services.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class FetchSimilarMoviesRemoteDataSource {
  Future<List<MovieModel>> fetchSimilarMovies({required int id});
}

class FetchSimilarMoviesRemoteDataSourceImpl
    extends FetchSimilarMoviesRemoteDataSource {
  ApiService apiService;
  FetchSimilarMoviesRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<MovieModel>> fetchSimilarMovies({required int id}) async {
    try {
      Response response =
          await apiService.get("${EndPoints.relatedMovies}?movie_id=$id");
      List<MovieModel> moviesList = [];

      for (var movie in response.data["data"]["movies"]) {
        moviesList.add(MovieModel.fromJson(movie as Map<String, dynamic>));
      }

      return moviesList;
    } on DioCustomException catch (e) {
      throw DioCustomException(dioException: e.dioException);
    } catch (e) {
      throw CustomException(errMessage: e.toString());
    }
  }
}
