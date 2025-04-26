import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies/core/services/api_services.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_details_model.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

abstract class HomeRemoteDataSource {
  Future<void> addMovieToHistory({required MovieEntity movie});
  Future<void> addMovieToWishList({required MovieEntity movie});
  Future<List<MovieModel>> fetchAvailableMovies();
  Future<List<MovieModel>> fetchSimilarMovies({required int id});
  Future<MovieDetailsModel> fetchMovieDetails({required int movieID});
  Future<List<MovieModel>> fetchWatchNowMovies();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  DatabaseServices databaseServices;
  LocalStorage localStorage;
    ApiService apiService;

  HomeRemoteDataSourceImpl({required this.databaseServices, required this.localStorage , required this.apiService});

  @override
    Future<void> addMovieToHistory({required MovieEntity movie}) async {
    bool isExisted = await databaseServices.checkIfDataExist(
        path: EndPoints.users,
        id: localStorage.getString(key: LocalStorage.userID)!,
        subCollectionID: movie.id.toString(),
        subCollectionName: EndPoints.history);

    if (!isExisted) {
      await databaseServices.storeData(
        subCollectionID: movie.id.toString(),
        path: EndPoints.users,
        data: movie.toJson(),
        id: localStorage.getString(key: LocalStorage.userID),
        subCollectionName: EndPoints.history,
      );
    } else {
      throw ServerException(
          errMessage: "Movie is already exist in the wishlist");
    }
  }

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
