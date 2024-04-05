class Doctor {
  final String fullName;
  final String specialty;
  final List<String> medicalSections;

  Doctor(this.fullName, this.specialty, this.medicalSections);
}

final List<Doctor> doctors = [
  Doctor('Dr. Jean Martin', 'Cardiologue', ['Cardiologie']),
  Doctor('Dr. Marie Dupont', 'Chirurgien plastique', ['Chirurgie']),
  Doctor('Dr. Paul Lefevre', 'Dermatologue', ['Dermatologie']),
  Doctor('Dr. Sophie Dubois', 'Gynécologue', ['Gynécologie']),
  Doctor('Dr. Pierre Lambert', 'Neurologue', ['Neurologie']),
  Doctor('Dr. Anne Renault', 'Orthopédiste', ['Orthopédie']),
  Doctor('Dr. Jacques Petit', 'Cardiologue', ['Cardiologie']),
  Doctor('Dr. Isabelle Rousseau', 'Chirurgien abdominal', ['Chirurgie']),
  Doctor('Dr. Étienne Moreau', 'Dermatologue', ['Dermatologie']),
  Doctor('Dr. Sandrine Berger', 'Gynécologue obstétricien', ['Gynécologie']),
  Doctor('Dr. Lucie Michel', 'Neurologue', ['Neurologie']),
  Doctor('Dr. Marc Leroy', 'Orthopédiste traumatologue', ['Orthopédie']),
  Doctor('Dr. Nathalie Roussel', 'Cardiologue pédiatrique', ['Cardiologie']),
  Doctor('Dr. Thomas Durand', 'Chirurgien cardiaque', ['Chirurgie']),
  Doctor('Dr. Camille Morel', 'Dermatologue pédiatrique', ['Dermatologie']),
];
