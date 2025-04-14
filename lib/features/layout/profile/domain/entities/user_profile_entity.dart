class UserProfileEntity {
  final String name;
  final String phone;

  UserProfileEntity({required this.name, required this.phone});

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  // Create object from JSON
  factory UserProfileEntity.fromJson(Map<String, dynamic> json) {
    return UserProfileEntity(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}