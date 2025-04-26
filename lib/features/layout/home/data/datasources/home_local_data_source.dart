import 'dart:developer';

import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';
import 'package:movies/features/layout/home/domain/entities/movie_entity.dart';

abstract class HomeLocalDataSource {
  void addMovieToHistory({required MovieEntity movie});
  List<MovieEntity> fetchMoviesFromHistory();
  Future<void> addMovieToWishList({required MovieEntity movie});
  Future<List<MovieEntity>> getWishList();
  Future<void> cacheLastAvailableMovies({required List<MovieModel> movies});
  Future<List<MovieModel>> fetchAvailableMovies();
  Future<void> storeWatchNowMovies({required List<MovieModel> movies});
  Future<List<MovieModel>> fetchWatchNowMovies();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final LocalStorage localStorage;

  HomeLocalDataSourceImpl({required this.localStorage});

  @override
  void addMovieToHistory({required MovieEntity movie}) {
    try {
      List<MovieEntity> oldMovieList =
          localStorage.getList<MovieEntity>(key: LocalStorage.history) ?? [];

      bool exists = false;
      for (var item in oldMovieList) {
        if (item.id == movie.id) {
          exists = true;
          break;
        }
      }

      if (!exists) {
        oldMovieList.add(movie);
        localStorage.setList<MovieEntity>(
            key: LocalStorage.history, value: oldMovieList);
      }
    } catch (e) {
      log("Exception in addMovieToHistory: ${e.toString()}");
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  List<MovieEntity> fetchMoviesFromHistory() {
    try {
      List<MovieEntity> movies =
          localStorage.getList<MovieEntity>(key: LocalStorage.history) ?? [];
      return movies;
    } catch (e) {
      log("Exception in fetchMoviesFromHistory: ${e.toString()}");
      throw CacheException(errMessage: e.toString());
    }
  }

  @override
  Future<void> addMovieToWishList({required MovieEntity movie}) async {
    try {
      List<MovieEntity> oldMoviesWishList =
          localStorage.getList<MovieEntity>(key: LocalStorage.wishList) ?? [];

      bool exists = false;
      for (var item in oldMoviesWishList) {
        if (item.id == movie.id) {
          exists = true;
          break;
        }
      }

      if (!exists) {
        oldMoviesWishList.add(movie);
        await localStorage.setList<MovieEntity>(
            key: LocalStorage.wishList, value: oldMoviesWishList);
      }
    } catch (e) {
      log("Exception in addMovieToWishList: ${e.toString()}");
      throw Exception("Failed to add movie to wishlist.");
    }
  }

  @override
  Future<List<MovieEntity>> getWishList() async {
    try {
      List<MovieEntity> movies =
          localStorage.getList<MovieEntity>(key: LocalStorage.wishList) ?? [];
      if (movies.isEmpty) {
        throw ("No internet Connection, please check your network");
      }
      return movies;
    } catch (e) {
      log("Exception in getWishList: ${e.toString()}");
      throw Exception("Failed to fetch wishlist.");
    }
  }

  @override
  Future<void> cacheLastAvailableMovies({required List<MovieModel> movies}) async {
    try {
      if (movies.isNotEmpty) {
        List<MovieModel> oldMovies =
            localStorage.getList<MovieModel>(key: LocalStorage.lastAvailableMoviesList) ?? [];

        if (!_areMovieListsEqual(oldMovies, movies)) {
          await localStorage.setList<MovieModel>(
              key: LocalStorage.lastAvailableMoviesList, value: movies);
        }
      }
    } catch (e) {
      log("Error in cacheLastAvailableMovies: ${e.toString()}");
    }
  }

  @override
  Future<List<MovieModel>> fetchAvailableMovies() async {
    try {
      List<MovieModel> movies =
          localStorage.getList<MovieModel>(key: LocalStorage.lastAvailableMoviesList) ?? [];
      if (movies.isEmpty) {
        throw CacheException(errMessage: "No internet connection, please check your network.");
      }
      return movies;
    } catch (e) {
      log("Error in fetchAvailableMovies: ${e.toString()}");
      throw Exception("Error fetching available movies: ${e.toString()}");
    }
  }

  @override
  Future<void> storeWatchNowMovies({required List<MovieModel> movies}) async {
    try {
      if (movies.isNotEmpty) {
        List<MovieModel> oldMovies =
            localStorage.getList<MovieModel>(key: LocalStorage.lastWatchNowMoviesList) ?? [];

        if (!_areMovieListsEqual(oldMovies, movies)) {
          await localStorage.setList<MovieModel>(
              key: LocalStorage.lastWatchNowMoviesList, value: movies);
        }
      }
    } catch (e) {
      log("Error in storeWatchNowMovies: ${e.toString()}");
    }
  }

  @override
  Future<List<MovieModel>> fetchWatchNowMovies() async {
    try {
      List<MovieModel> movies =
          localStorage.getList<MovieModel>(key: LocalStorage.lastWatchNowMoviesList) ?? [];
      if (movies.isEmpty) {
        throw CacheException(errMessage: "No internet connection, please check your network.");
      }
      return movies;
    } catch (e) {
      log("Error in fetchWatchNowMovies: ${e.toString()}");
      throw Exception("Error fetching watch now movies: ${e.toString()}");
    }
  }

  bool _areMovieListsEqual(List<MovieModel> oldList, List<MovieModel> newList) {
    if (oldList.length != newList.length) {
      return false;
    }
    for (int i = 0; i < oldList.length; i++) {
      if (oldList[i].id != newList[i].id) {
        return false;
      }
    }
    return true;
  }
}