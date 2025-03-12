
class SignUpUserRequest {
  final String userEmail;
  final String? password;
  final String userName;
  final String phone;

  SignUpUserRequest({
    required this.phone,
    required this.userEmail,
    required this.userName,
     this.password,
  });

    factory SignUpUserRequest.fromJson(Map<String, dynamic> json) {
    return SignUpUserRequest(
        phone: json["phone"],
        userName: json["userName"],
        userEmail: json["userEmail"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
      "userName": userName,
      "userEmail": userEmail,
    };
  }
}
