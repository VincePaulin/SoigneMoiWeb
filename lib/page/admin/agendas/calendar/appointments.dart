import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_web/function/admin_api.dart';
import 'package:soigne_moi_web/model/agenda.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:soigne_moi_web/widgets/custom_appointment_card.dart';
import 'package:soigne_moi_web/widgets/error_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

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
  List<Stay> allStays = [];
  Agenda? agenda;
  List<Widget> appointmentToSelectedDate = [];
  String? dateSelected;
  bool refresh = false;

  @override
  void initState() {
    super.initState();
    fetchAgenda();
    fetchAppointmentsForDoc();
    fetchStays();
  }

  void needRefreshPop() {
    setState(() => refresh = true);
  }

  void reloadStays() async {
    try {
      setState(() {
        staySelected = null;
        selectedStayDates = {};
      });
      fetchAgenda();
      fetchAppointmentsForDoc();
      fetchStays();
    } catch (e) {
      showErrorDialog(e.toString(), context);
    }
  }

  void fetchAgenda() async {
    try {
      Agenda? agendaData =
          await AdminApi().fetchAgendaByDoctorMatricule(widget.matricule);
      setState(() {
        agenda = agendaData;
      });
    } catch (e) {
      showErrorDialog(e.toString(), context);
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
          throw Exception('Échec de la récupération des rdv');
        }
      }

      setState(() {
        staysOfHisDoc = stayOfDoc;
        staysOfOtherDoc = otherStay;
      });
    } catch (e) {
      showErrorDialog(e.toString(), context);
    }
  }

  void fetchAppointmentsForDoc() async {
    try {
      List<Appointment>? appointmentsData = await AdminApi()
          .fetchAppointmentsForDoctorStartingToday(widget.matricule);
      // First check if the agenda exists
      // First check if appointmentsData is not null
      if (appointmentsData != null) {
        setState(() {
          // Add new appointments to the existing list of appointments in the 'agenda' object
          agenda!.appointments.addAll(appointmentsData);
        });
      }
    } catch (e) {
      showErrorDialog(e.toString(), context);
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

  bool hasOverlappingAppointments() {
    // Counting the number of hours worked for each day between startDate and endDate inclusive
    int overlappingCount = 0;
    final staySelected = this.staySelected;
    if (staySelected != null) {
      for (var date = staySelected.startDate;
          date.isBefore(staySelected.endDate);
          date = date.add(const Duration(days: 1))) {
        // Counting the number of jobs for the selected day
        final appointmentsForDay = agenda?.appointments
            .where((appointment) =>
                isSameDay(appointment.startDate, date) ||
                isSameDay(appointment.endDate, date) ||
                (appointment.startDate.isBefore(date) &&
                    appointment.endDate.isAfter(date)))
            .toList();

        // If the number of shifts for this day is already 5, increment the overlap counter.
        if (appointmentsForDay != null && appointmentsForDay.length >= 5) {
          overlappingCount++;
        }
      }
    } else {
      return false;
    }
    // If the overlap counter is greater than zero, there is at least one day with 5 appointments.
    return overlappingCount > 0;
  }

  // Function to create appointment
  Future<void> createEventCalendar(
      DateTime startDateTime, DateTime endDateTime) async {
    try {
      // Create the appointment using the provided start and end times
      Appointment newAppointment = Appointment(
        startDate: startDateTime,
        endDate: endDateTime,
        patientId: staySelected!.userId!,
        doctorMatricule: agenda!.doctor.matricule,
        stayId: staySelected!.id!,
        motif: staySelected!.motif,
      );

      await AdminApi().createAppointment(newAppointment);
      needRefreshPop();
      reloadStays();
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('RDV créé avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      showErrorDialog(e.toString(), context);
    }
  }

  Stay? findStayById(String id, List<Stay> stays) {
    for (var stay in stays) {
      if (stay.id == id) {
        return stay;
      }
    }
    return null;
  }

  Future<void> showAppointmentsForDay(DateTime date) async {
    final appointmentsForDay = agenda?.appointments
        .where((appointment) =>
            appointment.startDate.isBefore(date) &&
                appointment.endDate.isAfter(date) ||
            (isSameDay(appointment.startDate, date) &&
                isSameDay(appointment.endDate, date)))
        .toList();

    List<Widget> appointmentCards = [];
    int count = 0;
    if (appointmentsForDay != null && appointmentsForDay.isNotEmpty) {
      // Retrieve the full name of each user in parallel
      await Future.forEach(appointmentsForDay, (appointment) async {
        String? fullName =
            await AdminApi().getUserFullName(appointment.patientId);
        count += 1;

        appointmentCards.add(
          CustomAppointmentCard(
              appointmentIndex: count,
              appointment: appointment,
              fullName: fullName),
        );
      });
    }

    setState(() {
      appointmentToSelectedDate = appointmentCards;
      dateSelected = DateFormat('dd/MM/yyyy').format(date); // Fixed date format
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
