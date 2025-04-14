import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';

abstract class FetchListOfMoviesInHistoryRemoteDataSource {
  Future<List<MovieModel>> fetchListOfMoviesInHistory();
}

class FetchListOfMoviesInHistoryRemoteDataSourceImpl
    implements FetchListOfMoviesInHistoryRemoteDataSource {
  DatabaseServices databaseServices;
  LocalStorage localStorage;

  FetchListOfMoviesInHistoryRemoteDataSourceImpl(
      {required this.databaseServices, required this.localStorage});
  @override
  Future<List<MovieModel>> fetchListOfMoviesInHistory() {
   try {
  return databaseServices
       .fetchAllData(
           path: EndPoints.users,
           id: localStorage.getString(key: LocalStorage.userID)!,
           subCollectionName: EndPoints.history)
       .then((value) => value.map((e) => MovieModel.fromJson(e)).toList());
} on FirebaseException catch (e) {
  log("FirebaseException from FetchListOfMoviesInHistoryRemoteDataSourceImpl.fetchListOfMoviesInHistory and message is : ${e.toString()}");
  throw FirebaseException(plugin: e.toString());
} catch (e) {
  log("general exception from FetchListOfMoviesInHistoryRemoteDataSourceImpl.fetchListOfMoviesInHistory and message is : ${e.toString()}");
  throw Exception(e.toString());
  }
}
}
