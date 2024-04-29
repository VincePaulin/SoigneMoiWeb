class Doctor {
  final String fullName;
  final String specialty;
  final List<String> medicalSections;

  Doctor({
    required this.fullName,
    required this.specialty,
    required this.medicalSections,
  });
}

final List<Doctor> doctors = [
  Doctor(
      fullName: 'Dr. Jean Martin',
      specialty: 'Cardiologue',
      medicalSections: ['Cardiologie']),
  Doctor(
      fullName: 'Dr. Marie Dupont',
      specialty: 'Chirurgien plastique',
      medicalSections: ['Chirurgie']),
  Doctor(
      fullName: 'Dr. Paul Lefevre',
      specialty: 'Dermatologue',
      medicalSections: ['Dermatologie']),
  Doctor(
      fullName: 'Dr. Sophie Dubois',
      specialty: 'Gynécologue',
      medicalSections: ['Gynécologie']),
  Doctor(
      fullName: 'Dr. Pierre Lambert',
      specialty: 'Neurologue',
      medicalSections: ['Neurologie']),
  Doctor(
      fullName: 'Dr. Anne Renault',
      specialty: 'Orthopédiste',
      medicalSections: ['Orthopédie']),
  Doctor(
      fullName: 'Dr. Jacques Petit',
      specialty: 'Cardiologue',
      medicalSections: ['Cardiologie']),
  Doctor(
      fullName: 'Dr. Isabelle Rousseau',
      specialty: 'Chirurgien abdominal',
      medicalSections: ['Chirurgie']),
  Doctor(
      fullName: 'Dr. Étienne Moreau',
      specialty: 'Dermatologue',
      medicalSections: ['Dermatologie']),
  Doctor(
      fullName: 'Dr. Sandrine Berger',
      specialty: 'Gynécologue obstétricien',
      medicalSections: ['Gynécologie']),
  Doctor(
      fullName: 'Dr. Lucie Michel',
      specialty: 'Neurologue',
      medicalSections: ['Neurologie']),
  Doctor(
      fullName: 'Dr. Marc Leroy',
      specialty: 'Orthopédiste traumatologue',
      medicalSections: ['Orthopédie']),
  Doctor(
      fullName: 'Dr. Nathalie Roussel',
      specialty: 'Cardiologue pédiatrique',
      medicalSections: ['Cardiologie']),
  Doctor(
      fullName: 'Dr. Thomas Durand',
      specialty: 'Chirurgien cardiaque',
      medicalSections: ['Chirurgie']),
  Doctor(
      fullName: 'Dr. Camille Morel',
      specialty: 'Dermatologue pédiatrique',
      medicalSections: ['Dermatologie']),
];
