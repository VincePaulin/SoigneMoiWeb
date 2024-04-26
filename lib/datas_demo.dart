import 'model/doctor.dart';
import 'model/stay.dart';

final List<Doctor> doctorsDemo = [
  Doctor(
    fullName: "Dr. Jean Martin",
    specialty: "Cardiologue",
    medicalSections: ["Cardiologie"],
  ),
  Doctor(
    fullName: "Dr. Marie Dupont",
    specialty: "Chirurgien plastique",
    medicalSections: ["Chirurgie"],
  ),
  Doctor(
    fullName: "Dr. Paul Lefevre",
    specialty: "Dermatologue",
    medicalSections: ["Dermatologie"],
  ),
  Doctor(
    fullName: "Dr. Jean Martin",
    specialty: "Cardiologue",
    medicalSections: ["Cardiologie"],
  ),
  Doctor(
    fullName: "Dr. Marie Dupont",
    specialty: "Chirurgien plastique",
    medicalSections: ["Chirurgie"],
  ),
  Doctor(
    fullName: "Dr. Paul Lefevre",
    specialty: "Dermatologue",
    medicalSections: ["Dermatologie"],
  ),
  Doctor(
    fullName: "Dr. Jean Martin",
    specialty: "Cardiologue",
    medicalSections: ["Cardiologie"],
  ),
  Doctor(
    fullName: "Dr. Marie Dupont",
    specialty: "Chirurgien plastique",
    medicalSections: ["Chirurgie"],
  ),
  Doctor(
    fullName: "Dr. Paul Lefevre",
    specialty: "Dermatologue",
    medicalSections: ["Dermatologie"],
  ),

];


final List<Stay> staysDemo = [
  Stay(
      motif: "Consultation cardiologique",
      type: "Ambulatoire",
      startDate: DateTime(2024, 04, 25, 10, 00),
      endDate: DateTime(2024, 04, 25, 11, 00),
      precision: "Matin",
  ),
  Stay(
    motif: "Intervention chirurgicale plastique",
    type: "Hospitalisation",
    startDate: DateTime(2024, 05, 10, 08, 00),
    endDate: DateTime(2024, 05, 15, 12, 00),
  ),
  Stay(
    motif: "Contrôle dermatologique",
    type: "Ambulatoire",
    startDate: DateTime(2024, 03, 14, 14, 30),
    endDate: DateTime(2024, 03, 14, 15, 00),
  ),
  Stay(
    motif: "Consultation cardiologique",
    type: "Ambulatoire",
    startDate: DateTime(2024, 04, 25, 10, 00),
    endDate: DateTime(2024, 04, 25, 11, 00),
    precision: "Matin",
  ),
  Stay(
    motif: "Intervention chirurgicale plastique",
    type: "Hospitalisation",
    startDate: DateTime(2024, 05, 10, 08, 00),
    endDate: DateTime(2024, 05, 15, 12, 00),
  ),

  Stay(
    motif: "Contrôle dermatologique",
    type: "Ambulatoire",
    startDate: DateTime(2024, 03, 14, 14, 30),
    endDate: DateTime(2024, 03, 14, 15, 00),
  ),
  Stay(
    motif: "Consultation cardiologique",
    type: "Ambulatoire",
    startDate: DateTime(2024, 04, 25, 10, 00),
    endDate: DateTime(2024, 04, 25, 11, 00),
    precision: "Matin",
  ),

  Stay(
    motif: "Intervention chirurgicale plastique",
    type: "Hospitalisation",
    startDate: DateTime(2024, 05, 10, 08, 00),
    endDate: DateTime(2024, 05, 15, 12, 00),
  ),

  Stay(
    motif: "Contrôle dermatologique",
    type: "Ambulatoire",
    startDate: DateTime(2024, 03, 14, 14, 30),
    endDate: DateTime(2024, 03, 14, 15, 00),
  ),

];
