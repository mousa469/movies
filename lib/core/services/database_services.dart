import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseServices {
  Future storeData({
    required String path,
    required dynamic data,
    String? id,
    String? subCollectionName,
    String? subCollectionID,
  });
  Future<Map<String, dynamic>> fetchData({required String path, String? id});
  Future<bool> checkIfDataExist({
    required String path,
    required String id,
    String? subCollectionName,
    String? subCollectionID,
  });
}

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
          .set(data,);
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
}
