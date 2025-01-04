import 'package:cloud_firestore/cloud_firestore.dart';
import '../../config/constants.dart';
import '../models/patient_model.dart';
import '../models/prescription_model.dart';

class FirebaseDBService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Patients
  static Future<String> createOrUpdatePatient(PatientModel patient) async {
    final docRef = _db.collection('patients').doc(patient.uid.isEmpty ? null : patient.uid);
    if (patient.uid.isEmpty) {
      // Create new doc
      DocumentReference newDoc = await _db.collection('patients').add(patient.toMap());
      return newDoc.id;
    } else {
      // Update existing doc
      await docRef.set(patient.toMap(), SetOptions(merge: true));
      return patient.uid;
    }
  }

  static Future<List<PatientModel>> fetchAllPatients() async {
    QuerySnapshot snapshot = await _db.collection('patients').get();
    return snapshot.docs.map((doc) {
      return PatientModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  static Future<void> deletePatient(String id) async {
    await _db.collection('patients').doc(id).delete();
  }

  // Prescriptions
  static Future<String> createPrescription(PrescriptionModel prescription) async {
    DocumentReference docRef = await _db
        .collection(AppConstants.prescriptionsCollection)
        .add(prescription.toMap());
    return docRef.id;
  }

  static Future<List<PrescriptionModel>> getPatientPrescriptions(String patientId) async {
    QuerySnapshot snapshot = await _db
        .collection(AppConstants.prescriptionsCollection)
        .where('patientId', isEqualTo: patientId)
        .get();

    return snapshot.docs.map((doc) {
      return PrescriptionModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}