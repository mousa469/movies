import 'package:dio/dio.dart';
import 'package:movies/core/services/api_services.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class BrowseMovieByCategoryRemoteDataSource {
  Future<List<MovieModel>> browseMovieByCategory({required String category});
}

class BrowseMovieByCategoryRemoteDataSourceImpl
    implements BrowseMovieByCategoryRemoteDataSource {
  ApiService apiService;

  BrowseMovieByCategoryRemoteDataSourceImpl({required this.apiService});
  @override
  Future<List<MovieModel>> browseMovieByCategory(
      {required String category}) async {
    try {
      final response =
          await apiService.get("${EndPoints.category}?genre=$category");
      List<MovieModel> moviesList = [];
      for (var movie in response.data["data"]["movies"]) {
        moviesList.add(MovieModel.fromJson(movie));
      }
      return moviesList;
    } on DioException catch (e) {
      throw DioCustomException(dioException: e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
