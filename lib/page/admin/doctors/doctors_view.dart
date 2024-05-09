import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/doctor.dart';

import 'doctors/doctors.dart';

class AdminDoctorsView extends StatelessWidget {
  final DoctorsController controller;
  const AdminDoctorsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
      ),
      body: ListView.builder(
        itemCount: controller.doctorsList.length, // Remplacer doctorsList par votre liste de médecins
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                // Utilisez l'URL ou les données de votre médecin pour le CircleAvatar
                // Par exemple : backgroundImage: NetworkImage(doctorsList[index].avatarUrl),
                child: Text('A'), // Placeholder pour l'avatar
              ),
              title: Text(controller.doctorsList[index].fullName), // Nom du médecin
              subtitle: Text(controller.doctorsList[index].specialty), // Spécialité du médecin
              // Autres éléments de ListTile comme trailing si nécessaire
            ),
          );
        },
      ),
    );
  }
}
