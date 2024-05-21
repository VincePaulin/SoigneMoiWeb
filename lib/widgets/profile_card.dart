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
                radius: 60,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 15),
              Text(
                '${user.firstName} ${user.name}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "patient",
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "$numberOfStays Séjours",
                style: const TextStyle(fontSize: 18),
              ),
              // Text(
              //   "$numberOfPrescriptions Prescriptions",
              //   style: const TextStyle(fontSize: 18),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
