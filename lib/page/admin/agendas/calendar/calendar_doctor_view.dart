import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_web/page/admin/agendas/calendar/appointments.dart';

import 'calendar_appointments.dart';

class CalendarDoctorView extends StatelessWidget {
  final AppointmentsController controller;
  const CalendarDoctorView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Date format to display day and month only
    final DateFormat dateFormat = DateFormat('dd/MM');

    return Scaffold(
      appBar: AppBar(
        title: Text('Planning du docteur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: CalendarDoctorWidget(agenda: controller.agenda!)),
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900]?.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView.builder(
                  itemCount: controller.staysList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final stay = controller.staysList[index];
                    final String startDateFormatted =
                        dateFormat.format(stay.startDate);
                    final String endDateFormatted =
                        dateFormat.format(stay.endDate);
                    return ListTile(
                      title: Text(
                        stay.motif,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Du $startDateFormatted au $endDateFormatted',
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Action à effectuer lorsque l'utilisateur appuie sur un séjour
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
