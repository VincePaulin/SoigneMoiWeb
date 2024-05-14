import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soigne_moi_web/function/admin_api.dart';
import 'package:soigne_moi_web/model/agenda.dart';
import 'package:soigne_moi_web/widgets/error_dialog.dart';

import 'agendasListView.dart';

class AdminAgendas extends StatefulWidget {
  const AdminAgendas({super.key});

  @override
  AgendasController createState() => AgendasController();
}

class AgendasController extends State<AdminAgendas> {
  List<Agenda> agendasList = [];
  List<Appointment> appointmentsList = [];

  @override
  void initState() {
    super.initState();
    fetchAgendas(); // Calling the method to retrieve agendas
    fetchAppointments(); // Calling the method to retrieve appointments
    fetchDemandsPerDoctors();
  }

  void fetchAgendas() async {
    try {
      List<Agenda>? agendas = await AdminApi().fetchAllAgendas();
      setState(() {
        agendasList = agendas!;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch agendas: $e');
      }
    }
  }

  void fetchAppointments() async {
    try {
      // Fetch all appointments starting today
      List<Appointment>? appointments =
          await AdminApi().fetchAppointmentsStartingToday();

      // Iterate through each appointment
      if (appointments != null) {
        for (var appointment in appointments) {
          // Find the corresponding agenda using doctor matricule
          var agenda = agendasList.firstWhere(
            (agenda) => agenda.doctor.matricule == appointment.doctorMatricule,
          );

          // If an agenda is found, add the appointment to its list
          setState(() {
            agenda.appointments.add(appointment);
          });
        }
      }
    } catch (e) {
      showErrorDialog(e.toString(), context);
    }
  }

  void fetchDemandsPerDoctors() async {
    try {
      Map<String, int>? demands =
          await AdminApi().fetchDemandsCountForEachDoctor();
      if (demands != null) {
        // Iterate through each agenda
        for (var agenda in agendasList) {
          // Check if the doctor matricule exists in the demands map
          if (demands.containsKey(agenda.doctor.matricule)) {
            // Update the demands count for the agenda's doctor
            setState(() {
              agenda.demandsCount = demands[agenda.doctor.matricule];
            });
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get demands per doctor: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AgendasListView(
      controller: this,
    );
  }
}
