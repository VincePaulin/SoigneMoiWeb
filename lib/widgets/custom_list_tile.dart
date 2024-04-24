import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';

// Custom class for ListTiles with title, type and date
class CustomListTile extends StatelessWidget {
  final Stay stay;

  const CustomListTile({
    super.key,
    required this.stay,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(stay.startDate);
    String formattedEndDate = DateFormat('dd/MM/yyyy').format(stay.endDate);

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  stay.motif,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: robotoTextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  stay.type,
                  overflow: TextOverflow.ellipsis,
                  style: robotoTextStyle(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Début: $formattedDate',
                      overflow: TextOverflow.ellipsis,
                      style: robotoTextStyle(),
                    ),
                    Text(
                      'Fin: $formattedEndDate',
                      overflow: TextOverflow.ellipsis,
                      style: robotoTextStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
