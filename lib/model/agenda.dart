import 'package:soigne_moi_web/model/doctor.dart';

// Template for showing an appointment
class Appointment {
  final String? id;
  final DateTime startDate;
  final DateTime endDate;
  final String patientId;
  final String doctorMatricule;
  final String stayId;
  final String motif;

  Appointment({
    this.id,
    required this.startDate,
    required this.endDate,
    required this.patientId,
    required this.doctorMatricule,
    required this.stayId,
    required this.motif,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'].toString(),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      patientId: json['patient_id'].toString(),
      doctorMatricule: json['doctor_matricule'].toString(),
      stayId: json['stay_id'].toString(),
      motif: json['motif'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'patient_id': patientId,
      'doctor_matricule': doctorMatricule,
      'stay_id': stayId,
      'motif': motif,
    };
  }
}

// Model to represent a doctor's schedule
class Agenda {
  final String id;
  final Doctor doctor;
  late final List<Appointment> appointments;
  late int? demandsCount;

  Agenda({
    required this.id,
    required this.doctor,
    required this.appointments,
    this.demandsCount,
  });

  // Function to convert JSON to Agenda object
  factory Agenda.fromJson(Map<String, dynamic> json) {
    return Agenda(
      id: json['id'].toString(),
      doctor: Doctor.fromJson(json['doctor']),
      appointments: [],
      //appointments: List<Appointment>.from(json['appointments'].map((x) => Appointment.fromJson(x))),
    );
  }
}
