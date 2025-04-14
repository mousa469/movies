import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';

abstract class FetchNumberOfMoviesInHistoryRemoteDataSource {
  Future<int> fetchNumberOfMoviesInHistory();
}

class FetchNumberOfMoviesInHistoryRemoteDataSourceImpl
    implements FetchNumberOfMoviesInHistoryRemoteDataSource {
  DatabaseServices databaseServices;
  LocalStorage localStorage;

  FetchNumberOfMoviesInHistoryRemoteDataSourceImpl(
      {required this.databaseServices , required this.localStorage});

  @override
  Future<int> fetchNumberOfMoviesInHistory() async {
    try {
      int numberOfHistoryMovies = await databaseServices.getNumberOfRecords(
        path: EndPoints.users,
        id: localStorage.getString(key: LocalStorage.userID)!,
        subCollectionName: EndPoints.history,
      );

      return numberOfHistoryMovies;
    } on FirebaseException catch (e) {
      log("FirebaseException from FetchNumberOfMoviesInHistoryRemoteDataSourceImpl.fetchNumberOfMoviesInHistory and message is : ${e.toString()}");
      throw FirebaseException(plugin: e.toString());
    } catch (e) {
      log("general exception from FetchNumberOfMoviesInHistoryRemoteDataSourceImpl.fetchNumberOfMoviesInHistory and message is : ${e.toString()}");

      throw Exception(e.toString());
    }
  }
}
