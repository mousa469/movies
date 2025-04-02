import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies/core/services/api_services.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/features/layout/home/data/models/movie_details_model.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<MovieDetailsModel> fetchMovieDetails({required int movieID});
}

class FetchMovieDetailsRemoteDataSourceImpl
    extends MovieDetailsRemoteDataSource {
  ApiService apiService;
  FetchMovieDetailsRemoteDataSourceImpl({required this.apiService});
  @override
  Future<MovieDetailsModel> fetchMovieDetails({required int movieID}) async {
    try {
      Response response = await apiService.get(
          "${EndPoints.movieDetails}?movie_id=$movieID&with_images=true&with_cast=true");

      return MovieDetailsModel.fromJson(response.data["data"]["movie"]);
    } on DioCustomException catch (e) {
      log("exception come from dio exception in FetchMovieDetailsRemoteDataSourceImpl.fetchMovieDetails and message is : ${e.dioException.message} ");
      throw DioCustomException(dioException: e.dioException);
    } catch (e) {
      log("general  exception come from  in FetchMovieDetailsRemoteDataSourceImpl.fetchMovieDetails and message is : ${e.toString()} ");

      throw Exception(e.toString());
    }
  }
}
