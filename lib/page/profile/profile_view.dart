import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/doctor.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:soigne_moi_web/model/user.dart';
import 'package:soigne_moi_web/widgets/doctor_history_card.dart';
import 'package:soigne_moi_web/widgets/profile_card.dart';
import 'package:soigne_moi_web/widgets/stay_history_card.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  final List<Stay> stays;
  final List<Doctor> doctors;

  const ProfilePage(
      {super.key,
      required this.stays,
      required this.user,
      required this.doctors});

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
                  child: ProfileCard(
                    user: user,
                    numberOfStays: 5,
                    numberOfPrescriptions: 2,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                          child: StayHistoryCard(
                        stays: stays,
                      )),
                      Expanded(child: DoctorHistoryCard(doctors: doctors)),
                    ],
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
