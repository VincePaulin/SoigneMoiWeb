class Stay {
  final String motif;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final String? precision;
  final int? doctorId;

  Stay({
    required this.motif,
    required this.type,
    required this.startDate,
    required this.endDate,
    this.precision,
    this.doctorId,
  });

  factory Stay.fromJson(Map<String, dynamic> json) {
    return Stay(
      motif: json['motif'] ?? '',
      type: json['type'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      precision: json['precision'],
      doctorId: json['doctorId'], // Assuming doctorId is nullable in JSON
    );
  }
}
