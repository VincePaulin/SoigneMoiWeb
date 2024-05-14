import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_web/page/admin/agendas/calendar/appointments.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';
import 'package:soigne_moi_web/widgets/appointment_dialog.dart';
import 'package:soigne_moi_web/widgets/custom_avatar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDoctorWidget extends StatefulWidget {
  final AppointmentsController controller;

  const CalendarDoctorWidget({super.key, required this.controller});

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
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: _buildCustomHeader(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFormatButton(CalendarFormat.month),
              const SizedBox(
                width: 6.0,
              ),
              _buildFormatButton(CalendarFormat.week),
              const SizedBox(
                width: 6.0,
              ),
              _buildFormatButton(CalendarFormat.twoWeeks),
            ],
          ),
          const SizedBox(
            height: 12.0,
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
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            headerVisible: false,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, events) {
                final isToday = isSameDay(date, DateTime.now());
                final isPastDay = date.isBefore(DateTime.now());
                final isFutureDay = date.isAfter(DateTime.now());
                String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                String classicDate = DateFormat('dd/MM/yyyy').format(date);
                final isStaySelected =
                    widget.controller.selectedStayDates.isNotEmpty;
                final isStayDate = isStaySelected
                    ? widget.controller.selectedStayDates
                        .contains(DateTime.parse(formattedDate))
                    : true; // Compare with selected dates

                BoxDecoration? decoration;

                if (isToday) {
                  decoration = const BoxDecoration(
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
                      border: Border.all(
                          color: isStayDate
                              ? Colors.green
                              : Colors.grey.withOpacity(0.3),
                          width: 2),
                      borderRadius: BorderRadius.circular(8),
                      color: !isStayDate ? Colors.grey : null);
                }

                if (isStayDate && !isPastDay) {
                  return InkWell(
                    hoverColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      if (isStaySelected) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AppointmentDialog(
                              formattedDate: formattedDate,
                              classicDate: classicDate,
                              controller: widget.controller,
                              onAppointmentCreated:
                                  (startDateTime, endDateTime) =>
                                      widget.controller.createEventCalendar(
                                          startDateTime, endDateTime),
                            );
                          },
                        );
                      } else {
                        widget.controller.showAppointmentsForDay(date);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: decoration,
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: robotoTextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: decoration,
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: robotoTextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }
              },
              markerBuilder: (context, date, events) {
                final appointmentsForCurrentDate = widget
                    .controller.agenda?.appointments
                    .where(
                        (appointment) => isSameDay(appointment.startDate, date))
                    .toList();

                final isComplete = appointmentsForCurrentDate?.length == 5;
                if (appointmentsForCurrentDate!.isNotEmpty) {
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
                  return null;
                }
              },
            ),
            daysOfWeekVisible: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFormatButton(CalendarFormat format) {
    final isSelectedDateStay =
        widget.controller.selectedStayDates.contains(_selectedDay);
    final isSelected = _calendarFormat == format;

    return TextButton(
      onPressed: isSelected || isSelectedDateStay
          ? null // Make days unclickable if format is already selected
          : () {
              setState(() {
                _calendarFormat = format;
              });
            },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return isSelected ? Colors.blue : Colors.grey.withOpacity(0.3);
        }),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          _getFormatText(format),
          style: TextStyle(
              color: isSelected ? Colors.white : null, fontSize: 16.0),
        ),
      ),
    );
  }

  String _getFormatText(CalendarFormat format) {
    switch (format) {
      case CalendarFormat.month:
        return 'Mois';
      case CalendarFormat.week:
        return 'Semaine';
      case CalendarFormat.twoWeeks:
        return '2 semaines';
      default:
        return '';
    }
  }

  Widget _buildCustomHeader() {
    return Row(
      children: [
        CustomAvatar(
          sex: widget.controller.agenda!.doctor.sex,
          avatarUrl: widget.controller.agenda!.doctor.avatarURL,
        ),
        const SizedBox(width: 8),
        Text(
          DateFormat('MMMM yyyy').format(_focusedDay),
          style: robotoTextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime.utc(
                _focusedDay.year,
                _focusedDay.month - 1,
                _focusedDay.day,
              );
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime.utc(
                _focusedDay.year,
                _focusedDay.month + 1,
                _focusedDay.day,
              );
            });
          },
        ),
      ],
    );
  }
}
