import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';

class DoctorStaysList extends StatelessWidget {
  final DateFormat dateFormat = DateFormat('dd/MM');
  final List<Stay> stays;
  final Stay? selectedStay;
  final Function(Stay) onStaySelected;
  final Function(DateTime, DateTime) onCreateEventCalendar;

  DoctorStaysList({
    super.key,
    required this.stays,
    this.selectedStay,
    required this.onStaySelected,
    required this.onCreateEventCalendar,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (stays.isEmpty)
            Text(
              "Il n'y a pas de séjour demandé pour cet onglet",
              style: robotoTextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stays.length,
            itemBuilder: (BuildContext context, int index) {
              final stay = stays[index];
              final String startDateFormatted =
                  dateFormat.format(stay.startDate);
              final String endDateFormatted = dateFormat.format(stay.endDate);
              final isSelected = selectedStay == stay;
              return ListTile(
                selected: isSelected,
                title: Text(
                  stay.motif,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Du $startDateFormatted au $endDateFormatted',
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: isSelected
                    ? ElevatedButton(
                        onPressed: () {
                          onCreateEventCalendar(stay.startDate, stay.endDate);
                        },
                        child: Text('Poser sur cet agenda'),
                      )
                    : null, // Do not display anything on the right if the item is not selected
                onTap: () {
                  onStaySelected(stay);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
