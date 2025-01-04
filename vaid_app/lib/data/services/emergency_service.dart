import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../config/constants.dart';

class EmergencyService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Log an emergency event in Firestore
  static Future<void> callEmergency({
    required String patientId,
    required double lat,
    required double lng,
  }) async {
    await _db.collection(AppConstants.emergenciesCollection).add({
      'patientId': patientId,
      'lat': lat,
      'lng': lng,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}