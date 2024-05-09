import 'dart:convert';

class Doctor {
  final String fullName;
  final String specialty;
  final List<String> medicalSections;
  final String matricule;
  final String? avatarURL;

  Doctor({
    required this.fullName,
    required this.specialty,
    required this.medicalSections,
    required this.matricule,
    this.avatarURL,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      fullName: json['fullName'] ?? '',
      specialty: json['specialty'] ?? '',
      // Convert JSON string to string list
      medicalSections:
          List<String>.from(jsonDecode(json['medicalSections'] ?? '[]')),
      matricule: json['matricule'] ?? 0,
      avatarURL: json['avatarURL'],
    );
  }
}
