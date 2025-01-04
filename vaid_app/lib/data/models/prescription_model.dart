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

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      id: json['_id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'patientId': patientId,
        'doctorId': doctorId,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
      };
}
