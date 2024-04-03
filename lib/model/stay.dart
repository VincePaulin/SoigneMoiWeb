import 'dart:ui';

// Model representing data from a stay
class Stay {
  final String title;
  final String type;
  final String date;
  final VoidCallback onTap;

  Stay({
    required this.title,
    required this.type,
    required this.date,
    required this.onTap,
  });
}
