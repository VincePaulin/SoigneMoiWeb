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
    fetchAppointmentsForDoc();
    fetchStays();
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
          print('Échec de la récupération des rdv');
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

  void fetchAppointmentsForDoc() async {
    try {
      List<Appointment>? appointmentsData = await AdminApi()
          .fetchAppointmentsForDoctorStartingToday(widget.matricule);
      // First check if the agenda exists
      // First check if appointmentsData is not null
      setState(() {
        // Add new appointments to the existing list of appointments in the 'agenda' object
        agenda!.appointments.addAll(appointmentsData);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch appointments: $e');
      }
    }
  }

  // Indicator for storing dates of selected stays
  Stay? staySelected;
  Set<DateTime> selectedStayDates = {};

  // Function to update the dates of selected stays
  void updateSelectedStayDates(Stay stay) {
    setState(() {
      if (staySelected == stay) {
        // Deselect the stay if it is already selected
        staySelected = null;
        selectedStayDates.clear();
      } else {
        // Empty all selected dates
        selectedStayDates.clear();
        // Add the dates of the selected stay to the set
        for (var date = stay.startDate;
            date.isBefore(stay.endDate);
            date = date.add(const Duration(days: 1))) {
          selectedStayDates.add(date);
        }
        // Set the selected stay
        staySelected = stay;
      }
    });
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
