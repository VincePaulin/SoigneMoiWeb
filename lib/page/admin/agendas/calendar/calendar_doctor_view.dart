import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_web/page/admin/agendas/calendar/appointments.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';

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
                            Tab(text: 'Pour ce docteur'),
                            Tab(text: 'Autres docteurs'),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // First tab - For this doctor
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    if (controller.staysOfHisDoc.isEmpty)
                                      Text(
                                        "Il n'y a pas de séjour demandé pour cette onglet",
                                        style: robotoTextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          controller.staysOfHisDoc.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final stay =
                                            controller.staysOfHisDoc[index];
                                        final String startDateFormatted =
                                            dateFormat.format(stay.startDate);
                                        final String endDateFormatted =
                                            dateFormat.format(stay.endDate);
                                        final isSelected =
                                            controller.staySelected == stay;
                                        return ListTile(
                                          selected: isSelected,
                                          title: Text(
                                            stay.motif,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            'Du $startDateFormatted au $endDateFormatted',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          onTap: () {
                                            controller
                                                .updateSelectedStayDates(stay);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // Second tab - For other doctors
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    if (controller.staysOfOtherDoc.isEmpty)
                                      Text(
                                        "Il n'y a pas de séjour demandé pour cette onglet",
                                        style: robotoTextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          controller.staysOfOtherDoc.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final stay =
                                            controller.staysOfOtherDoc[index];
                                        final String startDateFormatted =
                                            dateFormat.format(stay.startDate);
                                        final String endDateFormatted =
                                            dateFormat.format(stay.endDate);
                                        final isSelected =
                                            controller.staySelected == stay;
                                        return ListTile(
                                          selected: isSelected,
                                          title: Text(
                                            stay.motif,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            'Du $startDateFormatted au $endDateFormatted',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          onTap: () {
                                            controller
                                                .updateSelectedStayDates(stay);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
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
