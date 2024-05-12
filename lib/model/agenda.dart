import 'package:soigne_moi_web/model/doctor.dart';

// Template for showing an appointment
class Appointment {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String patientId;
  final String doctorMatricule;
  final String stayId;

  Appointment({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.patientId,
    required this.doctorMatricule,
    required this.stayId,
  });
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
