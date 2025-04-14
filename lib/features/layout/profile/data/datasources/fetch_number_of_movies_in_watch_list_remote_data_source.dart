import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';

abstract class FetchNumberOfMoviesInWatchListRemoteDataSource {
  Future<int> fetchNumberOfMoviesInWatchList();
}

class FetchNumberOfMoviesInWatchListRemoteDataSourceImpl
    implements FetchNumberOfMoviesInWatchListRemoteDataSource {
  DatabaseServices databaseServices;
  LocalStorage localStorage;

  FetchNumberOfMoviesInWatchListRemoteDataSourceImpl(
      {required this.databaseServices , required this.localStorage});

  @override
  Future<int> fetchNumberOfMoviesInWatchList() async {
    try {
      int numberOfWatchListMovies = await databaseServices.getNumberOfRecords(
        path: EndPoints.users,
        id: localStorage.getString(key: LocalStorage.userID)!,
        subCollectionName: EndPoints.movies,
      );

      return numberOfWatchListMovies;
    } on FirebaseException catch (e) {
      log("FirebaseException from FetchNumberOfMoviesInHistoryRemoteDataSourceImpl.fetchNumberOfMoviesInHistory and message is : ${e.toString()}");
      throw FirebaseException(plugin: e.toString());
    } catch (e) {
      log("general exception from FetchNumberOfMoviesInHistoryRemoteDataSourceImpl.fetchNumberOfMoviesInHistory and message is : ${e.toString()}");

      throw Exception(e.toString());
    }
  }
}
