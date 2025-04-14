import 'package:movies/features/layout/profile/domain/entities/user_profile_entity.dart';
import 'package:hive/hive.dart';

part 'user_profile_model.g.dart';

@HiveType(typeId: 5)
class UserProfileModel extends UserProfileEntity {
  UserProfileModel({required super.name, required super.phone});

  // Create object from JSON
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
