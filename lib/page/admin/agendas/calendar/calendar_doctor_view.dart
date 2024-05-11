import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/admin/agendas/calendar/appointments.dart';

class CalendarDoctorView extends StatelessWidget {
  final AppointmentsController controller;
  const CalendarDoctorView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contenu de la page',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Liste de suggestion',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.grey[300],
                child: ListView.builder(
                  itemCount: controller.staysList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final stay = controller.staysList[index];
                    return ListTile(
                      title: Text(stay.motif),
                      subtitle: Text('Du ${stay.startDate} au ${stay.endDate}'),
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
