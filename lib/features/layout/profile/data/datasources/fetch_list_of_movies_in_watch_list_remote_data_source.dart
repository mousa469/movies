import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class FetchListOfMoviesInWatchListRemoteDataSource {
  Future<List<MovieModel>> fetchListOfMoviesInWatchList();
}

class FetchListOfMoviesInWatchListRemoteDataSourceImpl
    implements FetchListOfMoviesInWatchListRemoteDataSource {
  DatabaseServices databaseServices;
  LocalStorage localStorage;

  FetchListOfMoviesInWatchListRemoteDataSourceImpl(
      {required this.localStorage, required this.databaseServices});
  @override
  Future<List<MovieModel>> fetchListOfMoviesInWatchList() async {
    try {
      return databaseServices
          .fetchAllData(
              path: EndPoints.users,
              id: localStorage.getString(key: LocalStorage.userID)!,
              subCollectionName: EndPoints.movies)
          .then((value) => value.map((e) => MovieModel.fromJson(e)).toList());
    } on FirebaseException catch (e) {
      log("FirebaseException from FetchListOfMoviesInWatchListRemoteDataSourceImpl.fetchListOfMoviesInWatchList and message is : ${e.toString()}");
      throw FirebaseException(plugin: e.toString());
    } catch (e) {
      log("general exception from FetchListOfMoviesInWatchListRemoteDataSourceImpl.fetchListOfMoviesInWatchList and message is : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
