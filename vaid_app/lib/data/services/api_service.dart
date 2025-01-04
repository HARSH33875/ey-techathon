import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/constants.dart';

class ApiService {
  static Future<http.Response> getRequest(String endpoint, String token) async {
    final url = Uri.parse('${AppConstants.baseUrl}$endpoint');
    return http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  static Future<http.Response> postRequest(String endpoint, Map<String, dynamic> body, String token) async {
    final url = Uri.parse('${AppConstants.baseUrl}$endpoint');
    return http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );
  }

  static Future<http.Response> putRequest(String endpoint, Map<String, dynamic> body, String token) async {
    final url = Uri.parse('${AppConstants.baseUrl}$endpoint');
    return http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );
  }

  static Future<http.Response> deleteRequest(String endpoint, String token) async {
    final url = Uri.parse('${AppConstants.baseUrl}$endpoint');
    return http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
