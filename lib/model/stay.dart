import 'dart:ui';

// Model representing data from a stay
class Stay {
  final String title;
  final String type;
  final DateTime date;
  final DateTime endDate;
  final String? precision;

  Stay(
      {required this.title,
      required this.type,
      required this.date,
      required this.endDate,
      this.precision});
}
