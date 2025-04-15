import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies/core/services/api_services.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class SearchMovieRemoteDataSource {
  Future<List<MovieModel>> fetchSearchMovies({required String query});
}

class SearchMovieRemoteDataSourceImpl implements SearchMovieRemoteDataSource {
  ApiService apiService;

  SearchMovieRemoteDataSourceImpl({required this.apiService});
  @override
  Future<List<MovieModel>> fetchSearchMovies({required String query}) async {
    try {
      Response response =
          await apiService.get("${EndPoints.searchMovies}?query_term= $query");
      List<MovieModel> moviesList = [];
      for (var movie in response.data["data"]["movies"]) {
        moviesList.add(MovieModel.fromJson(movie));
      }
      return moviesList;
    } on DioException catch (e) {
      throw DioCustomException(dioException: e);
    } catch (e) {
      throw CustomException(errMessage: e.toString());
    }
  }
}
