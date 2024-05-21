import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_web/model/stay.dart';

class StayHistoryCard extends StatelessWidget {
  final List<Stay> stays;

  const StayHistoryCard({
    super.key,
    required this.stays,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white.withOpacity(0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Historique',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          if (stays.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Vous n'avez pas encore de séjours"),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: stays.length,
              itemBuilder: (context, index) {
                final stay = stays[index];
                final formattedStartDate =
                    DateFormat('dd/MM/yyyy').format(stay.startDate);
                final formattedEndDate =
                    DateFormat('dd/MM/yyyy').format(stay.endDate);
                return ListTile(
                  title: Text(
                      'Séjour du $formattedStartDate au $formattedEndDate'),
                  subtitle: Text('Motif: ${stay.motif}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
