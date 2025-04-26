import 'dart:developer';

import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';
import 'package:movies/features/layout/profile/data/models/user_profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<List<MovieModel>> fetchListOfMoviesInHistory();
  Future<void> storeListOfMoviesInHistory({required List<MovieModel> movies});
  List<MovieEntity> fetchListOfMoviesInWatchList();
  UserProfileModel fetchUserData();
  void storeUserData({required UserProfileModel user});
  int fetchNumberOfMoviesInHistory();
  void storeNumberOfMoviesInHistory({required int numberOfMovies});
  int fetchNumberOfMoviesInWatchList();
  void storeNumberOfMoviesInWatchList({required int numberOfMovies});
  void updateUserData({String? userName, String? userPhone});
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final LocalStorage localStorage;

  ProfileLocalDataSourceImpl({required this.localStorage});
  @override
  Future<List<MovieModel>> fetchListOfMoviesInHistory() async {
    try {
      List<MovieModel>? movies =
          localStorage.getList<MovieModel>(key: LocalStorage.history);
      if (movies != null && movies.isNotEmpty) {
        return movies;
      } else {
        return [];
      }
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  Future<void> storeListOfMoviesInHistory(
      {required List<MovieModel> movies}) async {
    try {
      localStorage.setList<MovieModel>(
          key: LocalStorage.history, value: movies);
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  List<MovieEntity> fetchListOfMoviesInWatchList() {
    try {
      var movies =
          localStorage.getList<MovieEntity>(key: LocalStorage.wishList);
      if (movies != null && movies.isNotEmpty) {
        log("movies are not empty and returned successfully");
        return movies;
      } else {
        log("movies are empty");
        return [];
      }
    } catch (e) {
      log("general exception from FetchListOfMoviesInWatchListLocalDataSourceImpl.fetchListOfMoviesInWatchList and message is : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  @override
  UserProfileModel fetchUserData() {
    try {
      UserProfileModel? userProfileModel = UserProfileModel(
          name: localStorage.getString(key: LocalStorage.userName)!,
          phone: localStorage.getString(key: LocalStorage.userPhone)!);
      return userProfileModel;
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  void storeUserData({required UserProfileModel user}) {
    try {
      localStorage.setString(key: LocalStorage.userName, value: user.name);
      localStorage.setString(key: LocalStorage.userPhone, value: user.phone);
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  int fetchNumberOfMoviesInHistory() {
    try {
      int? moviesNumber =
          localStorage.getInt(key: LocalStorage.numberOfHistoryMovies);
      if (moviesNumber != null) {
        log("number of movies is = $moviesNumber");
        return moviesNumber;
      } else {
        return 0;
      }
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  void storeNumberOfMoviesInHistory({required int numberOfMovies}) {
    localStorage.setInt(
        key: LocalStorage.numberOfHistoryMovies, value: numberOfMovies);
  }

  @override
  int fetchNumberOfMoviesInWatchList() {
    try {
      int? moviesNumber =
          localStorage.getInt(key: LocalStorage.numberOfWatchListMovies);
      if (moviesNumber != null) {
        log("number of movies is = $moviesNumber");
        return moviesNumber;
      } else {
        return 0;
      }
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  void storeNumberOfMoviesInWatchList({required int numberOfMovies}) {
    localStorage.setInt(
        key: LocalStorage.numberOfWatchListMovies, value: numberOfMovies);
  }

  @override
  void updateUserData({String? userName, String? userPhone}) {
    try {
      localStorage.setString(key: LocalStorage.userName, value: userName!);
      localStorage.setString(key: LocalStorage.userPhone, value: userPhone!);
    } catch (e) {
      throw CacheException(errMessage: e.toString());
    }
  }
}
