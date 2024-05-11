import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soigne_moi_web/function/admin_api.dart';
import 'package:soigne_moi_web/model/stay.dart';

import 'calendar_doctor_view.dart';

class Appointments extends StatefulWidget {
  final String matricule;
  const Appointments({super.key, required this.matricule});

  @override
  AppointmentsController createState() => AppointmentsController();
}

class AppointmentsController extends State<Appointments> {
  List<Stay> staysList = [];

  @override
  void initState() {
    super.initState();
    fetchStays(); // Calling the method to retrieve appointments
  }

  void fetchStays() async {
    try {
      List<Stay> stays =
          await AdminApi().fetchStaysByDoctorMatricule(widget.matricule);
      setState(() {
        staysList = stays;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch agendas: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CalendarDoctorView(
      controller: this,
    );
  }
}
