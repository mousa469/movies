class UserModel {
  final String? userID;
  final String userName;
  final String userEmail;
  final String phone;

  UserModel(
      {
      required this.phone,
      this.userID,
      required this.userName,
      required this.userEmail});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        phone: json["phone"],
        userID: json["userID"],
        userName: json["userName"],
        userEmail: json["userEmail"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
      "userID": userID,
      "userName": userName,
      "userEmail": userEmail,
    };
  }
}
