import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_web/function/admin_api.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import 'appointments.dart';

Future<void> showAppointmentsForDay(DateTime date,
    AppointmentsController controller, BuildContext context) async {
  final appointmentsForDay = controller.agenda?.appointments
      .where((appointment) => isSameDay(appointment.startDate, date))
      .toList();

  if (appointmentsForDay != null && appointmentsForDay.isNotEmpty) {
    List<Widget> appointmentCards = [];
    // Retrieve the full name of each user in parallel
    await Future.forEach(appointmentsForDay, (appointment) async {
      String? fullName =
          await AdminApi().getUserFullName(appointment.patientId);
      appointmentCards.add(
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName ??
                      "N/A", // Use the full name retrieved or display “N/A” if the name is empty
                  style: robotoTextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      DateFormat('HH:mm').format(appointment.startDate),
                      style: robotoTextStyle(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('HH:mm').format(appointment.endDate),
                      style: robotoTextStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Rendez-vous du ${DateFormat('dd-MM-yyyy').format(date)}',
            style: robotoTextStyle(),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: appointmentCards,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}
