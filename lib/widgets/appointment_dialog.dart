import 'package:flutter/material.dart';

// widget for time selection dialog box
class AppointmentDialog extends StatefulWidget {
  final String formattedDate;
  final Function(DateTime, DateTime) onAppointmentCreated;

  const AppointmentDialog({
    super.key,
    required this.formattedDate,
    required this.onAppointmentCreated,
  });

  @override
  State<AppointmentDialog> createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<AppointmentDialog> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.parse(widget.formattedDate);
    _selectedTime = TimeOfDay(hour: 10, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Pour le ${widget.formattedDate}"),
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
                items: List.generate(6, (index) {
                  final hour = 10 + index ~/ 3;
                  final minute = (index % 3) * 20;
                  return DropdownMenuItem<TimeOfDay>(
                    value: TimeOfDay(hour: hour, minute: minute),
                    child: Text(
                        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}'),
                  );
                }),
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
              _selectedTime.hour,
              _selectedTime.minute,
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
