import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soigne_moi_web/function/data_future.dart';
import 'package:soigne_moi_web/model/doctor.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:soigne_moi_web/model/user.dart';
import 'package:soigne_moi_web/widgets/doctor_history_card.dart';
import 'package:soigne_moi_web/widgets/profile_card.dart';
import 'package:soigne_moi_web/widgets/stay_history_card.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  final List<Stay> stays;

  const ProfilePage({
    super.key,
    required this.stays,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    // Recover all the personnel numbers contained in Stay
    final matricules = stays.map((stay) => stay.doctorId.toString()).toList();

    return FutureBuilder(
        future: fetchDoctors(matricules),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            if (kDebugMode) {
              print(snapshot.error);
            }
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final List<Doctor> doctors = snapshot.data!;

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
                              Expanded(
                                  child: DoctorHistoryCard(doctors: doctors)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('No data available');
          }
        });
  }
}
