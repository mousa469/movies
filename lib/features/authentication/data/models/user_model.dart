import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/features/authentication/data/models/sign_up_user_request.dart';
import 'package:movies/features/authentication/domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.uid,
    required super.phoneNumber,
  });

  factory UserModel.fromFirebase({
    required User user,
  }) {
    return UserModel(
      phoneNumber: user.phoneNumber ?? '',
      name: user.displayName ?? '',
      email: user.email ?? '',
      uid: user.uid,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      uid: json['uid'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'phoneNumber': phoneNumber,
    };
  }
}
