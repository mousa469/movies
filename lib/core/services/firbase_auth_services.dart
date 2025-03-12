import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/core/services/custom_exception.dart';

class FirebaseAuthServices {
  FirebaseAuth firebaseAuth;

  FirebaseAuthServices({required this.firebaseAuth});

  Future<User> createNewUser(
      {required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("exeception from  firebaseAuthServices.createNewUser and code is ${e.code}");
      if (e.code == 'weak-password') {
        throw CustomException(errMessage: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            errMessage: 'The account already exists for that email');
      } else if (e.code == "netword-request-failed") {
        throw CustomException(errMessage: "ensure connectivity of internet");
      } else {
        throw CustomException(
            errMessage: "An error occurred , Please try again later ");
      }
    } catch (e) {
      throw CustomException(
          errMessage: "An error occurred , Please try again later  ");
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("exeception from  firebaseAuthServices.createNewUser and code is ${e.code}");
      if (e.code == 'user-not-found') {
        throw CustomException(errMessage: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw CustomException(
            errMessage: 'Wrong password provided for that user.');
      } else if (e.code == "netword-request-failed") {
        throw CustomException(errMessage: "ensure connectivity of internet");
      } else {
        throw CustomException(errMessage: "Invalid Email or Password");
      }
    } catch (e) {
      throw CustomException(
          errMessage: "An error occurred , Please try again later  ");
    }
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return (await FirebaseAuth.instance.signInWithCredential(credential))
          .user!;
    } catch (e) {
      log("exception come from FirebaseAuthServices.signInWithGoogle and message is : ${e.toString()}");

      throw CustomException(errMessage: e.toString());
    }
  }

  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      await FacebookAuth.instance.logOut();

      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Once signed in, return the UserCredential
      return (await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential))
          .user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw CustomException(
            errMessage:
                'The account already exists with a different social app.');
      } else if (e.code == 'invalid-credential') {
        throw CustomException(
            errMessage:
                'Error occurred while accessing credentials. Try again.');
      } else if (e.code == "netword-request-failed") {
        throw CustomException(errMessage: "ensure connectivity of internet");
      } else {
        throw CustomException(
            errMessage: 'Error occurred using Facebook Sign-In. Try again.');
      }
    } catch (e) {
      throw CustomException(errMessage: e.toString());
    }
  }
}
