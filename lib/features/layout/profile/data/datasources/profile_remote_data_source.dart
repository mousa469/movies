import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/core/services/custom_exception.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';
import 'package:movies/features/layout/home/data/models/movie_model.dart';
import 'package:movies/features/layout/profile/data/models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<List<MovieModel>> fetchListOfMoviesInHistory();
  Future<List<MovieModel>> fetchListOfMoviesInWatchList();
  Future<int> fetchNumberOfMoviesInHistory();
  Future<int> fetchNumberOfMoviesInWatchList(); // fetched
  Future<UserProfileModel> fetchUserData(); //fetched
  Future<void> logOut();
  Future<void> updateUserData({String? userName, String? userPhone});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  DatabaseServices databaseServices;
  LocalStorage localStorage;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;

  ProfileRemoteDataSourceImpl(
      {required this.databaseServices,
      required this.localStorage,
      required this.firebaseAuth,
      required this.googleSignIn,
      required this.facebookAuth});
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

  @override
  Future<UserProfileModel> fetchUserData() async {
    return UserProfileModel.fromJson(await databaseServices.fetchData(
        path: EndPoints.users,
        id: localStorage.getString(key: LocalStorage.userID)));
  }

  @override
  Future<void> logOut() async {
    try {
      final loginMethod =
          localStorage.getString(key: LocalStorage.signInMethode);

      if (loginMethod == 'google') {
        await googleSignIn.signOut();
      } else if (loginMethod == 'facebook') {
        await facebookAuth.logOut();
      }

      await firebaseAuth.signOut();
      await localStorage.clearAllData();
    } on FirebaseException catch (e) {
      log("FirebaseException from LogOutRemoteDataSourceImpl.logOut and message is : ${e.toString()}");
      throw FirebaseException(plugin: e.toString());
    } catch (e) {
      log("general exception from LogOutRemoteDataSourceImpl.logOut and message is : ${e.toString()}");
      throw Exception(e.toString());
    }
  }


    @override
  Future<void> updateUserData({String? userName, String? userPhone}) {
    try {
      return databaseServices.updateUserData(
          userName: userName,
          userPhone: userPhone,
          userID: localStorage.getString(key: LocalStorage.userID)!);
    } catch (e) {
      throw ServerException(errMessage: e.toString());
    }
  }
}
