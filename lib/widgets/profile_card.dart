import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/user.dart';

class ProfileCard extends StatelessWidget {
  final User user;
  final int numberOfStays;
  final int numberOfPrescriptions;

  const ProfileCard({
    super.key,
    required this.user,
    required this.numberOfStays,
    required this.numberOfPrescriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white.withOpacity(0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 60, // Augmentez le rayon pour rendre l'avatar plus gros
                backgroundColor: Colors.blue,
                child: Icon(Icons.person,
                    size: 50,
                    color: Colors.white), // Augmentez la taille de l'icône
              ),
              SizedBox(
                  height:
                      15), // Augmentez la hauteur du vide pour séparer les éléments
              Text(
                user.name,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold), // Augmentez la taille de la police
              ),
              Text(
                "patient",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16), // Augmentez la taille de la police
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "$numberOfStays Séjours", // Utilisez la propriété numberOfStays
                style:
                    TextStyle(fontSize: 18), // Augmentez la taille de la police
              ),
              Text(
                "$numberOfPrescriptions Prescriptions", // Utilisez la propriété numberOfPrescriptions
                style:
                    TextStyle(fontSize: 18), // Augmentez la taille de la police
              ),
            ],
          ),
        ],
      ),
    );
  }
}
