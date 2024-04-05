import 'package:flutter/material.dart';

class CreateStayPage extends StatefulWidget {
  const CreateStayPage({super.key});

  @override
  State<CreateStayPage> createState() => _CreateStayPageState();
}

class _CreateStayPageState extends State<CreateStayPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  String _selectedType = 'Type A';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now()
      .add(Duration(days: 7)); // Default end date is 7 days from today

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      decoration: InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
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
                        });
                      },
                      items: <String>['Type A', 'Type B', 'Type C', 'Type D']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Select Type',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('Date: ${_formatDate(_startDate)}'),
                        ),
                        TextButton(
                          onPressed: () {
                            _selectStartDate(context);
                          },
                          child: Text('Date de départ'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Fin le: ${_formatDate(_endDate)}'),
                        ),
                        TextButton(
                          onPressed: () {
                            _selectEndDate(context);
                          },
                          child: Text('Choisir la date de fin'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed with submission
                      _submitForm();
                    }
                  },
                  child: Text('Créer le séjour'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to format date in 'MM/dd/yyyy' format
  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
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
      initialDate: _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  // Method to submit form data
  void _submitForm() {
    print('Title: ${_titleController.text}');
    print('Type: $_selectedType');
    print('Start Date: $_startDate');
    print('End Date: $_endDate');
  }
}
