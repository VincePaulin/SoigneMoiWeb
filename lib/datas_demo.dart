import 'model/doctor.dart';
import 'model/stay.dart';

final List<Doctor> doctorsDemo = [
  Doctor(
    fullName: "Dr. Jean Martin",
    specialty: "Cardiologue",
    medicalSections: ["Cardiologie"],
    matricule: "M12345",
  ),
  Doctor(
    fullName: "Dr. Marie Dupont",
    specialty: "Chirurgien plastique",
    medicalSections: ["Chirurgie"],
    matricule: "M23456",
  ),
  Doctor(
    fullName: "Dr. Paul Lefevre",
    specialty: "Dermatologue",
    medicalSections: ["Dermatologie"],
    matricule: "M34567",
  ),
];

final List<Stay> staysDemo = [
  Stay(
    motif: "Consultation cardiologique",
    type: "Ambulatoire",
    startDate: DateTime(2024, 04, 25, 10, 00),
    endDate: DateTime(2024, 04, 25, 11, 00),
    precision: "Matin",
    doctorId: 888, // Le Dr. Jean Martin est associé à ce séjour
  ),
  Stay(
    motif: "Intervention chirurgicale plastique",
    type: "Hospitalisation",
    startDate: DateTime(2024, 05, 10, 08, 00),
    endDate: DateTime(2024, 05, 15, 12, 00),
    doctorId: 888, // Le Dr. Marie Dupont est associé à ce séjour
  ),
  Stay(
    motif: "Contrôle dermatologique",
    type: "Ambulatoire",
    startDate: DateTime(2024, 03, 14, 14, 30),
    endDate: DateTime(2024, 03, 14, 15, 00),
    doctorId: 888, // Le Dr. Paul Lefevre est associé à ce séjour
  ),
];
