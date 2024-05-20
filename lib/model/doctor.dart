import 'dart:convert';

class Doctor {
  final String fullName;
  final String specialty;
  final List<String> medicalSections;
  final String matricule;
  final String? avatarURL;
  final String sex;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Doctor({
    required this.fullName,
    required this.specialty,
    required this.medicalSections,
    required this.matricule,
    this.avatarURL,
    required this.sex,
    this.createdAt,
    this.updatedAt,
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
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'specialty': specialty,
      'medicalSections': medicalSections.toList(),
      'matricule': matricule,
      'avatarURL': avatarURL,
      'sex': sex,
    };
  }
}
