import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/doctor.dart';
import 'package:soigne_moi_web/widgets/custom_avatar.dart';

import 'doctors.dart';

class AdminDoctorsView extends StatelessWidget {
  final DoctorsController controller;
  const AdminDoctorsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    List<Doctor> doctors = controller.filteredDoctorsList.isNotEmpty
        ? controller.filteredDoctorsList
        : controller.doctorsList;
    return Scaffold(
        appBar: AppBar(
          title: Text('Doctors'),
          actions: [
            DropdownButton<DoctorSortBy>(
              value: controller.sortBy,
              onChanged: (newValue) {
                controller.sortDoctorsBy(newValue!);
              },
              items: DoctorSortBy.values.map((sortOption) {
                return DropdownMenuItem<DoctorSortBy>(
                  value: sortOption,
                  child: Text(sortOption.toString().split('.').last),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () => controller.navigateToCreateDoctorPage(context),
                icon: const Icon(Icons.add),
                label: Text('Ajouter un docteur'),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  controller
                      .filterDoctors(value); // Calling up the filter function
                },
                decoration: const InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: CustomAvatar(
                        sex: doctors[index].sex,
                        avatarUrl: doctors[index].avatarURL,
                      ),
                      title: Text(doctors[index].fullName),
                      subtitle: Text(doctors[index].specialty),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
