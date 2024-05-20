import 'package:flutter/material.dart';
import 'package:soigne_moi_web/function/admin_api.dart';
import 'package:soigne_moi_web/model/doctor.dart';
import 'package:soigne_moi_web/page/admin/doctors/doctors_view.dart';

import 'create_doctor.dart';

enum DoctorSortBy {
  date,
  name,
  modification,
}

class AdminDoctors extends StatefulWidget {
  const AdminDoctors({super.key});

  @override
  DoctorsController createState() => DoctorsController();
}

class DoctorsController extends State<AdminDoctors> {
  List<Doctor> doctorsList = [];
  List<Doctor> filteredDoctorsList = [];

  DoctorSortBy sortBy = DoctorSortBy.date;

  @override
  void initState() {
    super.initState();
    fetchDoctors(); // Calling the method to retrieve doctors
  }

  void fetchDoctors() async {
    try {
      List<Doctor>? doctors = await AdminApi().fetchAllDoctors();
      setState(() {
        doctorsList = doctors!;
      });
    } catch (e) {
      print('Failed to fetch doctors: $e');
    }
  }

  void filterDoctors(String query) {
    setState(() {
      filteredDoctorsList = doctorsList
          .where((doctor) =>
              doctor.fullName.toLowerCase().contains(query.toLowerCase()) ||
              doctor.specialty.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void sortDoctorsBy(DoctorSortBy newSortBy) {
    if (newSortBy != sortBy) {
      // Checks if the new value is different from the old one
      setState(() {
        sortBy = newSortBy;
        if (sortBy == DoctorSortBy.date) {
          doctorsList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        } else if (sortBy == DoctorSortBy.name) {
          doctorsList.sort((a, b) => a.fullName.compareTo(b.fullName));
        } else if (sortBy == DoctorSortBy.modification) {
          // New condition for sorting by modification
          doctorsList.sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
        }
      });
    }
  }

  void navigateToCreateDoctorPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateDoctorPage()),
    );

    if (result == true) {
      // Refresh doctors list
      fetchDoctors();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminDoctorsView(
      controller: this,
    );
  }
}
