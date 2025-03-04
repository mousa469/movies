
class SignUpUserRequest {
  final String userEmail;
   String? userID;
  final String? password;
  final String userName;
  final String phone;

  SignUpUserRequest({
    required this.phone,
    required this.userEmail,
    this.userID,
    required this.userName,
     this.password,
  });

    factory SignUpUserRequest.fromJson(Map<String, dynamic> json) {
    return SignUpUserRequest(
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
