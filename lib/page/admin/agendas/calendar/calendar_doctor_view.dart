import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_web/page/admin/agendas/calendar/appointments.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';
import 'package:soigne_moi_web/widgets/doctor_stays_list.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (controller.refresh == true) {
              context.go('/admin', extra: 1);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: RichText(
          text: TextSpan(
            text: 'Agenda de ',
            style: robotoTextStyle(
              fontSize: 18,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '${controller.agenda?.doctor.fullName}',
                style: robotoTextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: CalendarDoctorWidget(
                    controller: controller,
                  )),
              if (controller.appointmentToSelectedDate.isNotEmpty)
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900]?.withOpacity(0.3),
                    ),
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Les rendez-vous du ${controller.dateSelected}",
                              style: robotoTextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller
                                      .appointmentToSelectedDate.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return controller
                                        .appointmentToSelectedDate[index];
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900]?.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          unselectedLabelStyle:
                              robotoTextStyle(color: Colors.white),
                          tabs: [
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Pour ce docteur"),
                                  const SizedBox(
                                    width: 2.0,
                                  ),
                                  if (controller.staysOfHisDoc.isNotEmpty)
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 10,
                                      child: Text(
                                        controller.staysOfHisDoc.length
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(controller
                                      .agenda!.doctor.medicalSections.first),
                                  const SizedBox(
                                    width: 2.0,
                                  ),
                                  if (controller.staysOfOtherDoc.isNotEmpty)
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 10,
                                      child: Text(
                                        controller.staysOfOtherDoc.length
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // First tab - For this doctor
                              DoctorStaysList(
                                stays: controller.staysOfHisDoc,
                                selectedStay: controller.staySelected,
                                onStaySelected:
                                    controller.updateSelectedStayDates,
                                onCreateEventCalendar:
                                    controller.createEventCalendar,
                                hasOverlapping:
                                    controller.hasOverlappingAppointments(),
                              ),
                              // Second tab - For other doctors
                              DoctorStaysList(
                                stays: controller.staysOfOtherDoc,
                                selectedStay: controller.staySelected,
                                onStaySelected:
                                    controller.updateSelectedStayDates,
                                onCreateEventCalendar:
                                    controller.createEventCalendar,
                                hasOverlapping:
                                    controller.hasOverlappingAppointments(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
