import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soigne_moi_web/model/agenda.dart';
import 'package:soigne_moi_web/page/admin/agendas/agendas.dart';
import 'package:soigne_moi_web/widgets/calendar_doctor_list.dart';

class AgendasListView extends StatelessWidget {
  final AgendasController controller;
  const AgendasListView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    List<Agenda> agendas = controller.agendasList;
    final itemCount = (agendas.length / 3).ceil();

    return Scaffold(
      appBar: AppBar(
        title: Text('Plannings des docteurs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: itemCount,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final startIndex = index * 3;
            final endIndex = startIndex + 3;
            final sublist = agendas.sublist(startIndex,
                endIndex > agendas.length ? agendas.length : endIndex);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: sublist
                  .map((planning) => Expanded(
                        child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                context.go('/admin/doctor-planning/${planning.doctor.matricule}'
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IgnorePointer(
                                      ignoring: true, // Allows tactile events to pass through
                                      child: CalendarDoctorListWidget(
                                        agenda: planning,
                                      ),
                                    ),
                                    Text(
                                      planning.doctor.fullName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
