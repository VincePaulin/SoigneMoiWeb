import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soigne_moi_web/function/admin_api.dart';
import 'package:soigne_moi_web/model/agenda.dart';
import 'package:soigne_moi_web/model/stay.dart';

import 'calendar_doctor_view.dart';

class Appointments extends StatefulWidget {
  final String matricule;
  const Appointments({super.key, required this.matricule});

  @override
  AppointmentsController createState() => AppointmentsController();
}

class AppointmentsController extends State<Appointments> {
  List<Stay> staysOfHisDoc = [];
  List<Stay> staysOfOtherDoc = [];
  Agenda? agenda;

  @override
  void initState() {
    super.initState();
    fetchAgenda();
    fetchStays(); // Calling the method to retrieve appointments
  }

  void fetchAgenda() async {
    try {
      Agenda? agendaData =
          await AdminApi().fetchAgendaByDoctorMatricule(widget.matricule);
      setState(() {
        agenda = agendaData;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch agenda: $e');
      }
    }
  }

  void fetchStays() async {
    try {
      final Map<String, List<Stay>>? staysByDoctorMatricule =
          await AdminApi().fetchStaysByDoctorMatricule(widget.matricule);
      List<Stay> stayOfDoc = [];
      List<Stay> otherStay = [];

      // Check if answer is non-zero
      if (staysByDoctorMatricule != null) {
        // Access the list of stays by the doctor with the specified personnel number
        stayOfDoc = staysByDoctorMatricule['stayOfHisDoc'] ?? [];

        // Access the list of stays by other doctors
        otherStay = staysByDoctorMatricule['stayOfOtherDoc'] ?? [];
      } else {
        if (kDebugMode) {
          print('Échec de la récupération des séjours');
        }
      }
      setState(() {
        staysOfHisDoc = stayOfDoc;
        staysOfOtherDoc = otherStay;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch stays: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return agenda != null
        ? CalendarDoctorView(
            controller: this,
          )
        : const Center(
            child: CircularProgressIndicator(), // Show a loading indicator
          );
  }
}
