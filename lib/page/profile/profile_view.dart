import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/doctor.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:soigne_moi_web/model/user.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  final List<Stay> stays;
  final List<Doctor> doctors;

  const ProfilePage({super.key, required this.stays, required this.user, required this.doctors});

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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.person, size: 40, color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Text(
                              user.name,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "patient",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                                "5 Séjours"
                            ),
                            Text(
                                "2 prescriptions"
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
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
                      Expanded(
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.all(8.0),
                          color: Colors.white.withOpacity(0.8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Docteurs vus',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              if (stays.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Vous n'avez pas encore eu de docteur"),
                                ),
                              Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: doctors.length,
                                          itemBuilder: (context, index) {
                                            final doctor = doctors[index];
                                            return Card(
                                              elevation: 5,
                                              margin: EdgeInsets.all(8.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.lightBlue[100],
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 30,
                                                      backgroundColor: Colors.blue,
                                                      child: Icon(Icons.person, size: 30, color: Colors.white),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      doctor.fullName,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
