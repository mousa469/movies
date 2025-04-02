import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies/core/services/api_services.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class AvailabeMoviesRemoteDataSource {
  Future<List<MovieModel>> fetchAvailableMovies();
}

class AvailabeMoviesRemoteDataSourceImp extends AvailabeMoviesRemoteDataSource {
  ApiService apiService;
  AvailabeMoviesRemoteDataSourceImp({required this.apiService});

  @override
  Future<List<MovieModel>> fetchAvailableMovies() async {
    try {
      Response response = await apiService.get(EndPoints.availabeMovies);
      List<MovieModel> movies = [];

      for (var movie in response.data["data"]["movies"]) {
        movies.add(MovieModel.fromJson(movie));
      }

      return movies;
    } on DioException catch (e) {
      log("dio exception from AvailabeMoviesRemoteDataSourceImp.fetchAvailableMovies and message is : ${e.message}  ");
      throw DioCustomException(dioException: e);
    } catch (e) {
      log("general exception from AvailabeMoviesRemoteDataSourceImp.fetchAvailableMovies and message is : ${e.toString()}  ");

        throw CustomException(errMessage: e.toString());
    }
  }
}
