import 'dart:convert';

class Doctor {
  final String fullName;
  final String specialty;
  final List<String> medicalSections;
  final String matricule;
  final String? avatarURL;
  final String sex;

  Doctor({
    required this.fullName,
    required this.specialty,
    required this.medicalSections,
    required this.matricule,
    this.avatarURL,
    required this.sex,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      fullName: json['fullName'] ?? '',
      specialty: json['specialty'] ?? '',
      // Convert JSON string to string list
      medicalSections:
          List<String>.from(jsonDecode(json['medicalSections'] ?? '[]')),
      matricule: json['matricule'] ?? 0,
      sex: json['sex'] ?? '',
      avatarURL: json['avatarURL'],
    );
  }
}
