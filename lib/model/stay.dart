import 'dart:ui';

// Model representing data from a stay
class Stay {
  final String motif;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final String? precision;

  Stay(
      {required this.motif,
      required this.type,
      required this.startDate,
      required this.endDate,
      this.precision});

  factory Stay.fromJson(Map<String, dynamic> json) {
    return Stay(
      motif: json['motif'] ?? '',
      type: json['type'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      precision: json['precision'],
    );
  }
}
