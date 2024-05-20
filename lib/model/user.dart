class User {
  final int id;
  final String name;
  final String firstName;
  final String email;
  final DateTime? emailVerifiedAt;
  final String? address;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.firstName,
    required this.email,
    required this.role,
    this.emailVerifiedAt,
    this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      firstName: json['first_name'],
      email: json['email'],
      role: json['role'] ?? "user",
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      address: json['address'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
