import 'package:soigne_moi_web/model/doctor.dart';

// Template for showing an appointment
import 'dart:convert';

class Appointment {
  final String? id;
  final DateTime startDate;
  final DateTime endDate;
  final String patientId;
  final String doctorMatricule;
  final String stayId;

  Appointment({
    this.id,
    required this.startDate,
    required this.endDate,
    required this.patientId,
    required this.doctorMatricule,
    required this.stayId,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      patientId: json['patient_id'],
      doctorMatricule: json['doctor_matricule'],
      stayId: json['stay_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'patient_id': patientId,
      'doctor_matricule': doctorMatricule,
      'stay_id': stayId,
    };
  }
}

// Model to represent a doctor's schedule
class Agenda {
  final String id;
  final Doctor doctor;
  final List<Appointment> appointments;

  Agenda({
    required this.id,
    required this.doctor,
    required this.appointments,
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
