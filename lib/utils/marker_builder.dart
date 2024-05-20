import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/agenda.dart';

class CustomMarkerBuilder {
  static Widget buildMarker(List<Appointment> appointments, DateTime date) {
    final appointmentsForCurrentDate = appointments
        .where((appointment) =>
            appointment.startDate.isBefore(date) &&
            appointment.endDate.isAfter(date))
        .toList();

    final isComplete = appointmentsForCurrentDate.length == 5;

    if (appointmentsForCurrentDate.isNotEmpty) {
      return CircleAvatar(
        backgroundColor: isComplete ? Colors.red : Colors.green,
        radius: 10,
        child: Text(
          '${appointmentsForCurrentDate.length}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      );
    } else {
      return const SizedBox
          .shrink(); // Return an empty widget if there are no events
    }
  }
}
