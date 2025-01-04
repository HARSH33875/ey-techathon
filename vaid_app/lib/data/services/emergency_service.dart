import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/constants.dart';

class EmergencyService {
  static Future<bool> callEmergency({
    required String patientId,
    required String token,
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse('${AppConstants.baseUrl}/api/emergency');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'patientId': patientId,
        'lat': latitude,
        'lng': longitude,
      }),
    );

    return response.statusCode == 200;
  }
}
