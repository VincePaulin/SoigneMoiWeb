import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/stay.dart';

// Custom class for ListTiles with title, type and date
class CustomListTile extends StatelessWidget {
  final Stay stay;

  const CustomListTile({
    super.key,
    required this.stay,
  });

  @override
  Widget build(BuildContext context) {
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
                  stay.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  stay.date,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
