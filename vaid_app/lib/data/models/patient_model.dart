class PatientModel {
  final String uid;    // Reference to the Firestore doc ID
  final String name;
  final List<String> diseaseHistory;
  final String? location; // Could store lat-long or address

  PatientModel({
    required this.uid,
    required this.name,
    required this.diseaseHistory,
    this.location,
  });

  factory PatientModel.fromMap(Map<String, dynamic> data, String documentId) {
    return PatientModel(
      uid: documentId,
      name: data['name'] ?? '',
      diseaseHistory: List<String>.from(data['diseaseHistory'] ?? []),
      location: data['location'],
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'diseaseHistory': diseaseHistory,
        'location': location,
      };
}