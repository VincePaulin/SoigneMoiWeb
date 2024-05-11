import 'package:flutter/material.dart';

class CalendarDoctorView extends StatelessWidget {
  final String matricule;
  const CalendarDoctorView({super.key, required this.matricule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planning du docteur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contenu de la page',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Liste de suggestion',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    'Suggestion 1\nSuggestion 2\nSuggestion 3',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
