import 'package:flutter/material.dart';
import 'package:soigne_moi_web/function/admin_api.dart';
import 'package:soigne_moi_web/model/doctor.dart';
import 'package:soigne_moi_web/page/admin/doctors/doctors.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';
import 'package:soigne_moi_web/widgets/custom_avatar.dart';
import 'package:soigne_moi_web/widgets/error_dialog.dart';

class DoctorDetailsDialog extends StatelessWidget {
  final Doctor doctor;
  final DoctorsController controller;

  const DoctorDetailsDialog(
      {super.key, required this.doctor, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              // Profile image
              Expanded(
                flex: 1,
                child: ProfileDoctorImage(
                  sex: doctor.sex,
                  avatarUrl: doctor.avatarURL,
                ),
              ),
              // Doctor's details
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileHead(),
                          _buildProfileDetail(),
                        ],
                      ),
                      // Profile creation date
                      _buildProfileDate(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Row(
              children: [
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Supprimer le profil'),
                    ),
                    // Add more options if needed
                  ],
                  onSelected: (String value) async {
                    if (value == 'delete') {
                      // Call the function to delete the doctor
                      String? result =
                          await AdminApi().deleteDoctor(doctor.matricule);
                      if (result == "success") {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Le docteur a été supprimé avec succès')),
                        );
                        // Refreshes the list of doctors after successful deletion
                        controller.fetchDoctors();
                      } else {
                        showErrorDialog(result!, context);
                      }
                    }
                  },
                ),
                const SizedBox(width: 10),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHead() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profile",
          style: TextStyle(
            color: Colors.red,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          doctor.fullName,
          style: montserratTextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Matricule:',
          style: montserratTextStyle(
            color: Colors.red,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          doctor.matricule,
          style: montserratTextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildProfileDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specialty:',
          style: montserratTextStyle(
            color: Colors.red,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          doctor.specialty,
          style: montserratTextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          children: doctor.medicalSections.map((section) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Chip(
                label: Text(
                  section,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildProfileDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile créé le: ${doctor.createdAt}',
          style: robotoTextStyle(color: Colors.white),
        ),

        // Date of last modification
        Text(
          'Dernière modification: ${doctor.updatedAt}',
          style: robotoTextStyle(color: Colors.white),
        ),
      ],
    );
  }
}