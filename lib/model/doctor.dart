import 'dart:convert';

class Doctor {
  final String fullName;
  final String specialty;
  final List<String> medicalSections;
  final String matricule;

  Doctor({
    required this.fullName,
    required this.specialty,
    required this.medicalSections,
    required this.matricule,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      fullName: json['fullName'] ?? '',
      specialty: json['specialty'] ?? '',
      // Convertir la chaîne JSON en liste de chaînes
      medicalSections:
          List<String>.from(jsonDecode(json['medicalSections'] ?? '[]')),
      matricule: json['matricule'] ?? 0,
    );
  }
}

final List<Doctor> doctors = [
  Doctor(
    fullName: 'Dr. Jean Martin',
    specialty: 'Cardiologue',
    medicalSections: ['Cardiologie'],
    matricule: "123456",
  ),
  Doctor(
    fullName: 'Dr. Marie Dupont',
    specialty: 'Chirurgien plastique',
    medicalSections: ['Chirurgie'],
    matricule: "234567",
  ),
  Doctor(
    fullName: 'Dr. Paul Lefevre',
    specialty: 'Dermatologue',
    medicalSections: ['Dermatologie'],
    matricule: "345678",
  ),
  Doctor(
    fullName: 'Dr. Sophie Dubois',
    specialty: 'Gynécologue',
    medicalSections: ['Gynécologie'],
    matricule: "456789",
  ),
  Doctor(
    fullName: 'Dr. Pierre Lambert',
    specialty: 'Neurologue',
    medicalSections: ['Neurologie'],
    matricule: "567890",
  ),
  Doctor(
    fullName: 'Dr. Anne Renault',
    specialty: 'Orthopédiste',
    medicalSections: ['Orthopédie'],
    matricule: "678901",
  ),
  Doctor(
    fullName: 'Dr. Jacques Petit',
    specialty: 'Cardiologue',
    medicalSections: ['Cardiologie'],
    matricule: "789012",
  ),
  Doctor(
    fullName: 'Dr. Isabelle Rousseau',
    specialty: 'Chirurgien abdominal',
    medicalSections: ['Chirurgie'],
    matricule: "890123",
  ),
  Doctor(
    fullName: 'Dr. Étienne Moreau',
    specialty: 'Dermatologue',
    medicalSections: ['Dermatologie'],
    matricule: "901234",
  ),
  Doctor(
    fullName: 'Dr. Sandrine Berger',
    specialty: 'Gynécologue obstétricien',
    medicalSections: ['Gynécologie'],
    matricule: "012345",
  ),
  Doctor(
    fullName: 'Dr. Lucie Michel',
    specialty: 'Neurologue',
    medicalSections: ['Neurologie'],
    matricule: "123456",
  ),
  Doctor(
    fullName: 'Dr. Marc Leroy',
    specialty: 'Orthopédiste traumatologue',
    medicalSections: ['Orthopédie'],
    matricule: "234567",
  ),
  Doctor(
    fullName: 'Dr. Nathalie Roussel',
    specialty: 'Cardiologue pédiatrique',
    medicalSections: ['Cardiologie'],
    matricule: "345678",
  ),
  Doctor(
    fullName: 'Dr. Thomas Durand',
    specialty: 'Chirurgien cardiaque',
    medicalSections: ['Chirurgie'],
    matricule: "456789",
  ),
  Doctor(
    fullName: 'Dr. Camille Morel',
    specialty: 'Dermatologue pédiatrique',
    medicalSections: ['Dermatologie'],
    matricule: "567890",
  ),
];
