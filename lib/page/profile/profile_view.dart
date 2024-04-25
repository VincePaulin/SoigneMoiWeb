import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/stay.dart';

class ProfilePage extends StatelessWidget {
  final List<Stay> stays;

  const ProfilePage({super.key, required this.stays});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 5,
                    color: Colors.white.withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Historique de séjours',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                              return ListTile(
                                title: Text(
                                    'Séjour du ${stay.startDate} au ${stay.endDate}'),
                                subtitle: Text('Motif: ${stay.motif}'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
