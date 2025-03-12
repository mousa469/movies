import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/constants.dart';
import 'package:movies/features/authentication/data/models/sign_up_user_request.dart';
import 'package:movies/features/authentication/data/models/user_model.dart';

class FirebaseFirestoreService {
  FirebaseFirestore firebaseFirestore;
  FirebaseFirestoreService({required this.firebaseFirestore});

  void storeUserInfoInFirestore(UserModel userModel, SignUpUserRequest user) {
    CollectionReference users = firebaseFirestore.collection(usersCollection);
    users.add(user.toJson());
  }
}
