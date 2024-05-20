import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/agenda.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';

class CustomAppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final String? fullName;
  final int appointmentIndex;

  const CustomAppointmentCard({
    super.key,
    required this.appointment,
    this.fullName,
    required this.appointmentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First column for appointment number
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child: Center(
                  child: Text(
                    appointmentIndex.toString(),
                    style: robotoTextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Vertical line to separate columns
              const VerticalDivider(
                width: 30,
                thickness: 5,
                color: Colors.grey,
              ),
              // Second column for fullName and Text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FullName en gris
                  Text(
                    fullName ?? "N/A",
                    style: robotoTextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appointment.motif,
                    style: robotoTextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
