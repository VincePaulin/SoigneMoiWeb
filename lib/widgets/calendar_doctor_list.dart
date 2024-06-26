import 'package:flutter/material.dart';
import 'package:soigne_moi_web/utils/marker_builder.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:soigne_moi_web/model/agenda.dart';

class CalendarDoctorListWidget extends StatefulWidget {
  final Agenda agenda;

  const CalendarDoctorListWidget({super.key, required this.agenda});

  @override
  State<CalendarDoctorListWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarDoctorListWidget> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: null, // Disable day selection
      headerVisible: false, // Hide the entire header
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, events) {
          final isToday = isSameDay(date, DateTime.now());
          final isPastDay = date.isBefore(DateTime.now());
          final isFutureDay = date.isAfter(DateTime.now());
          final isWeekend = date.weekday == 6 || date.weekday == 7;

          BoxDecoration decoration;

          if (isToday) {
            decoration = const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            );
          }
          if (isFutureDay) {
            decoration = const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            );
          }
          if (isPastDay || isWeekend) {
            decoration = BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.3),
            );
          }

          return Container(
            margin: const EdgeInsets.all(4.0),
            //decoration: decoration,
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  color: isPastDay ? Colors.grey : Colors.black,
                ),
              ),
            ),
          );
        },
        markerBuilder: (context, date, events) {
          return CustomMarkerBuilder.buildMarker(
              widget.agenda.appointments, date);
        },
      ),
    );
  }
}
