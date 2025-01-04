import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/constants.dart';
import '../models/user_model.dart';

class AuthService {
  // Register
  static Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final url = Uri.parse('${AppConstants.baseUrl}/api/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'role': role,  // 'doctor' or 'patient'
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data);
    } else {
      // Handle error
      return null;
    }
  }

  // Login
  static Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${AppConstants.baseUrl}/api/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data);
    } else {
      return null;
    }
  }
}
