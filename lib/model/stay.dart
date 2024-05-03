import 'doctor.dart';

class Stay {
  final String motif;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final String? precision;
  final String doctorMatricule;

  Stay({
    required this.motif,
    required this.type,
    required this.startDate,
    required this.endDate,
    this.precision,
    required this.doctorMatricule,
  });

  factory Stay.fromJson(Map<String, dynamic> json) {
    return Stay(
      motif: json['motif'] ?? '',
      type: json['type'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      precision: json['precision'],
      doctorMatricule: json['doctorMatricule'],
    );
  }
}
