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
      startDate: _parseDate(json['start_date']),
      endDate: _parseDate(json['end_date']),
      precision: json['precision'],
      doctorId: json['doctorId'], // Assuming doctorId is nullable in JSON
    );
  }

  static DateTime _parseDate(dynamic date) {
    if (date == null) {
      return DateTime.now();
    }
    // Assuming date is in the format 'yyyy-MM-ddTHH:mm:ss.000000Z'
    final parsedDate = DateTime.parse(date);
    return DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
  }

  Map<String, dynamic> toJson() {
    return {
      'motif': motif,
      'type': type,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'precision': precision,
      'doctorId': doctorId,
    };
  }
}
