import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/core/services/local_storage/local_storage.dart';

abstract class LogOutDataSource {
  Future<void> logOut();
}

class LogOutRemoteDataSourceImpl implements LogOutDataSource {
   final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;
  LocalStorage localStorage;
  LogOutRemoteDataSourceImpl({required this.localStorage ,required this.firebaseAuth,required this.googleSignIn,required this.facebookAuth,});

  @override
  Future<void> logOut() async {
     try {
  final loginMethod = localStorage.getString(key: LocalStorage.signInMethode);
  
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
  }

