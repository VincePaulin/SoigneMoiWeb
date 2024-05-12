import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/agenda.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDoctorWidget extends StatefulWidget {
  final Agenda agenda;

  const CalendarDoctorWidget({Key? key, required this.agenda})
      : super(key: key);

  @override
  State<CalendarDoctorWidget> createState() => _CalendarDoctorWidgetState();
}

class _CalendarDoctorWidgetState extends State<CalendarDoctorWidget> {
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFormatButton(CalendarFormat.month),
            _buildFormatButton(CalendarFormat.week),
            _buildFormatButton(CalendarFormat.twoWeeks),
          ],
        ),
        TableCalendar(
          headerStyle: const HeaderStyle(formatButtonVisible: false),
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
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
          },
          headerVisible: true,
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, date, events) {
              final isToday = isSameDay(date, DateTime.now());
              final isPastDay = date.isBefore(DateTime.now());
              final isFutureDay = date.isAfter(DateTime.now());

              BoxDecoration? decoration;

              if (isToday) {
                decoration = BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                );
              } else if (isPastDay) {
                decoration = BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.3),
                );
              } else if (isFutureDay) {
                decoration = BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                );
              }

              return Container(
                margin: const EdgeInsets.all(4.0),
                decoration: decoration,
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
              final appointmentsForCurrentDate = widget.agenda.appointments
                  .where(
                      (appointment) => isSameDay(appointment.startDate, date))
                  .toList();

              if (appointmentsForCurrentDate.isNotEmpty) {
                return CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Text(
                    '${appointmentsForCurrentDate.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                );
              } else {
                return null;
              }
            },
          ),
          daysOfWeekVisible: true,
        ),
      ],
    );
  }

  Widget _buildFormatButton(CalendarFormat format) {
    return TextButton(
      onPressed: () {
        setState(() {
          _calendarFormat = format;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return _calendarFormat == format ? Colors.blue : null;
        }),
      ),
      child: Text(
        _getFormatText(format),
        style: TextStyle(
          color: _calendarFormat == format ? Colors.white : null,
        ),
      ),
    );
  }

  String _getFormatText(CalendarFormat format) {
    switch (format) {
      case CalendarFormat.month:
        return 'Month';
      case CalendarFormat.week:
        return 'Week';
      case CalendarFormat.twoWeeks:
        return '2 Weeks';
      default:
        return '';
    }
  }
}
