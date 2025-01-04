import 'package:cloud_firestore/cloud_firestore.dart';

class PrescriptionModel {
  final String id;
  final String patientId;
  final String doctorId;
  final String description;
  final DateTime createdAt;

  PrescriptionModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.description,
    required this.createdAt,
  });

  factory PrescriptionModel.fromMap(Map<String, dynamic> data, String documentId) {
    return PrescriptionModel(
      id: documentId,
      patientId: data['patientId'] ?? '',
      doctorId: data['doctorId'] ?? '',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'patientId': patientId,
        'doctorId': doctorId,
        'description': description,
        'createdAt': createdAt,
      };
}