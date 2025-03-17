class UserEntity {
  final String name;
  final String email;
  final String uid;
  final String phoneNumber;

  UserEntity(
      {required this.name,
      required this.email,
      required this.uid,
      required this.phoneNumber});

  toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "phone": phoneNumber,
    };
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
        name: json['name'],
        email: json["email"],
        uid: json["uid"],
        phoneNumber: json["phone"]);
  }
}
