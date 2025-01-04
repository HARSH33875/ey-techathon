class UserModel {
  final String id;
  final String email;
  final String name;
  final String role; // e.g., doctor or patient
  final String token; // JWT token from server, if using

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      token: json['token'] ?? '',
    );
  }
}
