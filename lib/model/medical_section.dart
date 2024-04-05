class MedicalSection {
  final String name;
  final List<String> departments;

  MedicalSection(this.name, this.departments);
}

final List<MedicalSection> medicalSections = [
  MedicalSection(
    'Cardiologie',
    [
      'Cardiologie pédiatrique',
      'Électrophysiologie',
      'Interventionnelle',
      'Soins intensifs'
    ],
  ),
  MedicalSection(
    'Chirurgie',
    [
      'Chirurgie abdominale',
      'Chirurgie cardiaque',
      'Chirurgie générale',
      'Chirurgie plastique'
    ],
  ),
  MedicalSection(
    'Dermatologie',
    [
      'Dermatologie pédiatrique',
      'Dermatologie chirurgicale',
      'Dermatologie esthétique'
    ],
  ),
  MedicalSection(
    'Gynécologie',
    [
      'Gynécologie pédiatrique',
      'Gynécologie oncologique',
      'Gynécologie obstétrique'
    ],
  ),
  MedicalSection(
    'Neurologie',
    [
      'Neurologie pédiatrique',
      'Neurologie interventionnelle',
      'Neurologie vasculaire'
    ],
  ),
  MedicalSection(
    'Orthopédie',
    [
      'Orthopédie pédiatrique',
      'Orthopédie traumatologique',
      'Orthopédie oncologique'
    ],
  ),
];
