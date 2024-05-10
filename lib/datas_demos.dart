import 'model/agenda.dart';

List<Agenda> agendasDemoData = [
  Agenda(
    id: '1',
    doctorMatricule: 'DR12345',
    appointments: [
      Appointment(
        id: '1',
        title: 'Checkup',
        startDate: DateTime.now().add(Duration(days: 1)),
        endDate: DateTime.now().add(Duration(days: 1, hours: 1)),
        description: 'Regular checkup',
        patientId: 'P123',
      ),
      Appointment(
        id: '2',
        title: 'Follow-up',
        startDate: DateTime.now().add(Duration(days: 2)),
        endDate: DateTime.now().add(Duration(days: 2, hours: 1)),
        description: 'Follow-up appointment',
        patientId: 'P456',
      ),
    ],
  ),
  Agenda(
    id: '3',
    doctorMatricule: 'DR67890',
    appointments: [
      Appointment(
        id: '3',
        title: 'Consultation',
        startDate: DateTime.now().add(Duration(days: 3)),
        endDate: DateTime.now().add(Duration(days: 3, hours: 1)),
        description: 'Consultation for surgery',
        patientId: 'P789',
      ),
    ],
  ),
  Agenda(
    id: '4',
    doctorMatricule: 'DR12345',
    appointments: [
      Appointment(
        id: '1',
        title: 'Checkup',
        startDate: DateTime.now().add(Duration(days: 1)),
        endDate: DateTime.now().add(Duration(days: 1, hours: 1)),
        description: 'Regular checkup',
        patientId: 'P123',
      ),
      Appointment(
        id: '5',
        title: 'Follow-up',
        startDate: DateTime.now().add(Duration(days: 2)),
        endDate: DateTime.now().add(Duration(days: 2, hours: 1)),
        description: 'Follow-up appointment',
        patientId: 'P456',
      ),
    ],
  ),
  Agenda(
    id: '6',
    doctorMatricule: 'DR67890',
    appointments: [
      Appointment(
        id: '3',
        title: 'Consultation',
        startDate: DateTime.now().add(Duration(days: 3)),
        endDate: DateTime.now().add(Duration(days: 3, hours: 1)),
        description: 'Consultation for surgery',
        patientId: 'P789',
      ),
    ],
  ),
  Agenda(
    id: '7',
    doctorMatricule: 'DR12345',
    appointments: [
      Appointment(
        id: '1',
        title: 'Checkup',
        startDate: DateTime.now().add(Duration(days: 1)),
        endDate: DateTime.now().add(Duration(days: 1, hours: 1)),
        description: 'Regular checkup',
        patientId: 'P123',
      ),
      Appointment(
        id: '8',
        title: 'Follow-up',
        startDate: DateTime.now().add(Duration(days: 2)),
        endDate: DateTime.now().add(Duration(days: 2, hours: 1)),
        description: 'Follow-up appointment',
        patientId: 'P456',
      ),
    ],
  ),
  Agenda(
    id: '8',
    doctorMatricule: 'DR67890',
    appointments: [
      Appointment(
        id: '3',
        title: 'Consultation',
        startDate: DateTime.now().add(Duration(days: 3)),
        endDate: DateTime.now().add(Duration(days: 3, hours: 1)),
        description: 'Consultation for surgery',
        patientId: 'P789',
      ),
    ],
  ),
];

List<Appointment> appointmentsDemoData = [
  Appointment(
    id: '1',
    title: 'Checkup',
    startDate: DateTime.now().add(Duration(days: 1)),
    endDate: DateTime.now().add(Duration(days: 1, hours: 1)),
    description: 'Regular checkup',
    patientId: 'P123',
  ),
  Appointment(
    id: '2',
    title: 'Follow-up',
    startDate: DateTime.now().add(Duration(days: 2)),
    endDate: DateTime.now().add(Duration(days: 2, hours: 1)),
    description: 'Follow-up appointment',
    patientId: 'P456',
  ),
  Appointment(
    id: '3',
    title: 'Consultation',
    startDate: DateTime.now().add(Duration(days: 3)),
    endDate: DateTime.now().add(Duration(days: 3, hours: 1)),
    description: 'Consultation for surgery',
    patientId: 'P789',
  ),
];
