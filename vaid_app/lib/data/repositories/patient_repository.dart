import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/patient_model.dart';
import '../services/api_service.dart';

class PatientRepository {
  final String token;

  PatientRepository(this.token);

  Future<List<PatientModel>> fetchAllPatients() async {
    final response = await ApiService.getRequest('/api/patients', token);
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => PatientModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load patients');
    }
  }

  Future<PatientModel> createPatient(PatientModel patient) async {
    final response = await ApiService.postRequest(
      '/api/patients',
      patient.toJson(),
      token,
    );
    if (response.statusCode == 201) {
      return PatientModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create patient');
    }
  }

  // Similarly, update or delete patient records
}
