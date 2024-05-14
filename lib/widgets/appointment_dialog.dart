import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/admin/agendas/calendar/appointments.dart';

// widget for time selection dialog box
class AppointmentDialog extends StatefulWidget {
  final String formattedDate;
  final String classicDate;
  final AppointmentsController controller;
  final Function(DateTime, DateTime) onAppointmentCreated;

  const AppointmentDialog({
    super.key,
    required this.formattedDate,
    required this.onAppointmentCreated,
    required this.classicDate,
    required this.controller,
  });

  @override
  State<AppointmentDialog> createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<AppointmentDialog> {
  late DateTime _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.parse(widget.formattedDate);
  }

  // Function to build dropdown items
  List<DropdownMenuItem<TimeOfDay>> _buildDropdownItems() {
    // Initialize list of dropdown menu items
    List<DropdownMenuItem<TimeOfDay>> items = [];

    // Generate dropdown menu items for available times
    for (int index = 0; index < 6; index++) {
      final hour = 10 + index ~/ 3;
      final minute = (index % 3) * 20;
      final appointmentTime = TimeOfDay(hour: hour, minute: minute);

      // Check if the appointment time is available
      if (!_isAppointmentTimeTaken(appointmentTime)) {
        items.add(
          DropdownMenuItem<TimeOfDay>(
            value: appointmentTime,
            child: Text(
              '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
            ),
          ),
        );
      }
    }

    return items;
  }

// Function to check if an appointment time is taken
  bool _isAppointmentTimeTaken(TimeOfDay appointmentTime) {
    // Get the selected date in DateTime format
    DateTime selectedDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      appointmentTime.hour,
      appointmentTime.minute,
    );

    // Iterate through existing appointments to check if the time is taken
    for (var appointment in widget.controller.agenda!.appointments) {
      // Check if the appointment falls within the same hour
      if (appointment.startDate.isAtSameMomentAs(selectedDateTime)) {
        return true; // Appointment time is taken
      }
    }

    return false; // Appointment time is available
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Pour le ${widget.classicDate}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sélectionnez l\'heure de début :'),
          Row(
            children: [
              // Dropdown for selecting hour and minute
              DropdownButton<TimeOfDay>(
                value: _selectedTime,
                onChanged: (TimeOfDay? value) {
                  if (value != null) {
                    setState(() {
                      _selectedTime = value;
                    });
                  }
                },
                items: _buildDropdownItems(),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            // Create the appointment
            DateTime startDateTime = DateTime(
              _selectedDate.year,
              _selectedDate.month,
              _selectedDate.day,
              _selectedTime!.hour,
              _selectedTime!.minute,
            );
            DateTime endDateTime = startDateTime.add(Duration(minutes: 20));
            widget.onAppointmentCreated(startDateTime, endDateTime);
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: Text('Valider'),
        ),
      ],
    );
  }
}
