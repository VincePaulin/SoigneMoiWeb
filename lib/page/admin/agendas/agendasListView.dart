import 'package:flutter/material.dart';
import 'package:soigne_moi_web/datas_demos.dart';
import 'package:soigne_moi_web/model/agenda.dart';
import 'package:soigne_moi_web/widgets/calendar_doctor_list.dart';

class AgendasListView extends StatelessWidget {
  const AgendasListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Agenda> agendas = agendasDemoData;
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
                        child: GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CalendarDoctorListWidget(
                                    agenda: planning,
                                  ),
                                  Text(
                                    'Doctor: ${planning.doctorMatricule}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
