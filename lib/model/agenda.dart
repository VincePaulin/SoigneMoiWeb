import 'package:flutter/material.dart';

// Template for showing an appointment
class Appointment {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String patientId;

  Appointment({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.patientId,
  });
}

// Model to represent a doctor's schedule
class Agenda {
  final String id;
  final String doctorMatricule;
  final List<Appointment> appointments;

  Agenda({
    required this.id,
    required this.doctorMatricule,
    required this.appointments,
  });
}
