import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/core/services/database_services.dart';
import 'package:movies/core/services/end_points.dart';
import 'package:movies/core/services/keys.dart';

class FirebaseFirestoreService implements DatabaseServices {
  FirebaseFirestore firebaseFirestore;
  FirebaseFirestoreService({required this.firebaseFirestore});
  @override
  Future storeData({
    required String path,
    required dynamic data,
    String? id,
    String? subCollectionName,
    String? subCollectionID,
  }) async {
    if (subCollectionName != null && subCollectionID != null) {
      await firebaseFirestore
          .collection(path)
          .doc(id)
          .collection(subCollectionName)
          .doc(subCollectionID)
          .set(
            data,
          );
    } else {
      if (id != null) {
        await firebaseFirestore.collection(path).doc(id).set(data);
      } else {
        await firebaseFirestore.collection(path).add(data);
      }
    }
  }

  @override
  Future<Map<String, dynamic>> fetchData(
      {required String path, String? id}) async {
    var data = await firebaseFirestore.collection(path).doc(id).get();
    return data.data() as Map<String, dynamic>;
  }

  @override
  Future<bool> checkIfDataExist({
    required String path,
    required String id,
    String? subCollectionName,
    String? subCollectionID,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> data;
    if (subCollectionName != null && subCollectionID != null) {
      data = await firebaseFirestore
          .collection(path)
          .doc(id)
          .collection(subCollectionName)
          .doc(subCollectionID)
          .get();
      return data.exists;
    } else {
      data = await firebaseFirestore.collection(path).doc(id).get();
      return data.exists;
    }
  }

  @override
  Future<int> getNumberOfRecords(
      {required String path,
      required String id,
      String? subCollectionName}) async {
    var snapShots;
    if (subCollectionName != null) {
      snapShots = await firebaseFirestore
          .collection(path)
          .doc(id)
          .collection(subCollectionName)
          .get();

      log("number of movies is = ${snapShots.docs.length} ");
      return snapShots.docs.length;
    } else {
      snapShots = await firebaseFirestore.collection(path).doc(id).get();
      return snapShots.data().length;
    }
  }

  @override
  Future<void> updateUserData(
      {String? userName, String? userPhone, required String userID}) async {
    return await firebaseFirestore
        .collection(EndPoints.users)
        .doc(userID)
        .update({
      Keys.name: userName,
      Keys.phone: userPhone,
    }).then((value) {
      log("User Updated");
    }).catchError((error) {
      log("Failed to update user: $error");
    });
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllData(
      {required String path, required String id, String? subCollectionName}) {
    if (subCollectionName != null) {
      return firebaseFirestore
          .collection(path)
          .doc(id)
          .collection(subCollectionName)
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
    } else {
      final querySnapshot = firebaseFirestore
          .collection(path)
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());

      return querySnapshot;
    }
  }
}
