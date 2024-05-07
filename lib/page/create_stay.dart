import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soigne_moi_web/model/doctor.dart';
import 'package:soigne_moi_web/model/medical_section.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';
import 'package:soigne_moi_web/widgets/error_dialog.dart';

import '../function/data_future.dart';

class CreateStayPage extends StatefulWidget {
  const CreateStayPage({super.key});

  @override
  State<CreateStayPage> createState() => _CreateStayPageState();
}

class _CreateStayPageState extends State<CreateStayPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _precisionController = TextEditingController();
  String _selectedType =
      medicalSections.isNotEmpty ? medicalSections[0].name : '';
  String _selectedDoctor = 'Pas de préférence';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now()
      .add(Duration(days: 7)); // Default end date is 7 days from today

  List<DropdownMenuItem<String>> _getDoctorDropdownItems() {
    List<DropdownMenuItem<String>> items = [];
    if (_selectedType == 'Pas de préférence') {
      items.add(DropdownMenuItem<String>(
        value: 'Pas de préférence',
        child: Text('Pas de préférence'),
      ));
    } else {
      for (Doctor doctor in doctors) {
        if (doctor.medicalSections.contains(_selectedType)) {
          items.add(DropdownMenuItem<String>(
            value: doctor.matricule.toString(),
            child: Text(doctor.fullName),
          ));
        }
      }
      items.add(DropdownMenuItem<String>(
        value: 'Pas de préférence',
        child: Text('Pas de préférence'),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 5,
      color: Colors.white.withOpacity(0.9),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        labelText: 'Motif du séjour',
                        labelStyle: robotoTextStyle(
                            color: CupertinoColors.inactiveGray)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Un motif est requis';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedType = newValue!;
                        _selectedDoctor = 'Pas de préférence';
                      });
                    },
                    style: robotoTextStyle(),
                    items: medicalSections.map((section) {
                      return DropdownMenuItem<String>(
                        value: section.name,
                        child: Text(
                          section.name,
                          style: robotoTextStyle(),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: "Sélectionner le type d'intervention",
                      labelStyle: robotoTextStyle(),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedDoctor,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDoctor = newValue!;
                      });
                    },
                    style: robotoTextStyle(),
                    items: _getDoctorDropdownItems(),
                    decoration: InputDecoration(
                      labelText: 'Sélectionner le médecin',
                      labelStyle: robotoTextStyle(),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _precisionController,
                    decoration: InputDecoration(
                        labelText: 'Précision',
                        labelStyle: robotoTextStyle(
                            color: CupertinoColors.inactiveGray)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Date: ${_formatDate(_startDate)}',
                          style: robotoTextStyle(),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _selectStartDate(context);
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Choisir la date de départ',
                              style: robotoTextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Fin le: ${_formatDate(_endDate)}',
                          style: robotoTextStyle(),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _selectEndDate(context);
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Choisir la date de fin',
                              style: robotoTextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed with submission
                      _submitForm();
                    }
                  },
                  child: Text(
                    'Confirmation ',
                    style: montserratTextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to format date in 'MM/dd/yyyy' format
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Method to show date picker for selecting start date
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  // Method to show date picker for selecting end date
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: _startDate, // FirstDate to the selected startDate
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  // Method to submit form data
  void _submitForm() async {
    final doctorId = _selectedDoctor == 'Pas de préférence'
        ? null
        : "123456"; // Replace 0 with the selected doctor's ID

    final stay = Stay(
      motif: _titleController.text,
      type: _selectedType,
      startDate: _startDate,
      endDate: _endDate,
      precision: _precisionController.text,
      doctorId: doctorId,
    );

    final response = await createStay(stay: stay);

    if (response == 'success') {
      if (kDebugMode) {
        print('Stay created successfully');
      }
      // Resetting form fields after successful submission
      _titleController.clear();
      _precisionController.clear();

      // Display a toast to indicate that the stay has been successfully registered
      Fluttertoast.showToast(
        msg: "Le séjour est enregistré avec succès",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 10, // 10 sec
        backgroundColor: Colors.green.withOpacity(0.9),
        textColor: Colors.white, // Modifier la couleur du texte
        fontSize: 16.0, // Modifier la taille de la police
      );
    } else {
      // Afficher le dialogue d'erreur en utilisant showErrorDialog
      showErrorDialog(response, context);
    }
  }
}
