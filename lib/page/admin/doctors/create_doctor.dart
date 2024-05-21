import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:soigne_moi_web/function/admin_api.dart';
import 'package:soigne_moi_web/model/doctor.dart';
import 'package:soigne_moi_web/model/medical_section.dart';

class CreateDoctorPage extends StatefulWidget {
  const CreateDoctorPage({super.key});

  @override
  State<CreateDoctorPage> createState() => _CreateDoctorPageState();
}

class _CreateDoctorPageState extends State<CreateDoctorPage> {
  final _formKey = GlobalKey<FormState>();
  late String _fullName;
  late String _lastName;
  late String _firstName;
  late String _matricule;
  late String _sex;
  late String _specialty;
  List<String> _medicalSections = [];
  List<String> _selectedMedicalSections = [];
  XFile? _pickedFile;

  String? errorMessage;

  bool _isSpecialtySelected = false;

  String? _avatarURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Créer un docteur'),
        ),
        body: Center(
          child: SizedBox(
            width: 800,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAvatar(),
                        const SizedBox(height: 20),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(56.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildNameFields(),
                              _buildSexDropdown(),
                              _buildSpecialtyDropdown(),
                              _buildMedicalSectionsDropdown(),
                              _buildMatriculeField(),
                            ],
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_buildCreateButton()],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (errorMessage != null)
                      Center(
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
        _avatarURL = pickedFile.path;
      });
    }
  }

  Widget _buildAvatar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage:
                  _avatarURL != null ? NetworkImage(_avatarURL!) : null,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(70),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            _pickImage();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.camera_alt, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Mettre une photo de profil',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameFields() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Nom'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer le nom du docteur';
              }
              return null;
            },
            onSaved: (value) {
              _lastName = value!;
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Prénom'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer le prénom du docteur';
              }
              return null;
            },
            onSaved: (value) {
              _firstName = value!;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSexDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'Sexe'),
      items: ['Homme', 'Femme', 'Autre']
          .map((sex) => DropdownMenuItem(
                value: sex,
                child: Text(sex),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _sex = value!;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez sélectionner le sexe du docteur';
        }
        return null;
      },
    );
  }

  Widget _buildSpecialtyDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'Spécialité'),
      items: medicalSections
          .map((section) => DropdownMenuItem(
                value: section.name,
                child: Text(section.name),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _specialty = value!;
          _isSpecialtySelected = true;
          // Update medical sections according to selected specialty
          updateMedicalSections();
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez sélectionner une spécialité';
        }
        return null;
      },
    );
  }

  void updateMedicalSections() {
    // Filter medical sections by selected specialty
    var selectedMedicalSection = medicalSections.firstWhere(
        (section) => section.name == _specialty,
        orElse: () => MedicalSection('', []));
    // Update _medicalSections with new departments
    setState(() {
      _medicalSections = selectedMedicalSection.departments.toList();
    });
  }

  Widget _buildMedicalSectionsDropdown() {
    List<String> items = _isSpecialtySelected ? _medicalSections.toList() : [];

    return MultiSelectDialogField(
      items: items.map((e) => MultiSelectItem(e, e)).toList(),
      listType: MultiSelectListType.LIST,
      onConfirm: (values) {
        _selectedMedicalSections = values;
      },
    );
  }

  Widget _buildMatriculeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Matricule'),
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.length != 7 ||
            int.tryParse(value) == null) {
          return 'Le matricule doit contenir 7 chiffres';
        }
        return null;
      },
      onSaved: (value) {
        _matricule = value!;
      },
    );
  }

  Widget _buildCreateButton() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          errorMessage = null;
        });
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          _fullName = 'Dr. $_firstName $_lastName';

          Doctor newDoctor = Doctor(
            fullName: _fullName,
            specialty: _specialty,
            medicalSections: _selectedMedicalSections,
            matricule: _matricule,
            avatarURL: _avatarURL,
            sex: _sex,
          );

          String? response =
              await AdminApi().createDoctor(newDoctor, _pickedFile);

          if (response == 'success') {
            // Pop with a result indicating success
            Navigator.pop(context, true);
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Docteur créé avec succès'),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            setState(() {
              errorMessage = response;
            });
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'Créer le docteur',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
