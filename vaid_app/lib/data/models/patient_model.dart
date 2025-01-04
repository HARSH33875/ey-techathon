class PatientModel {
  final String id;
  final String name;
  final List<String> diseaseHistory;
  final String? location; // lat,long

  PatientModel({
    required this.id,
    required this.name,
    required this.diseaseHistory,
    this.location,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['_id'],
      name: json['name'],
      diseaseHistory: List<String>.from(json['diseaseHistory'] ?? []),
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'diseaseHistory': diseaseHistory,
        'location': location,
      };
}
