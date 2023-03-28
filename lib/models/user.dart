class User {
  final String email;
  final String firstName;
  String? lastName;

  User({
    required this.email,
    required this.firstName,
    this.lastName,
  });
}
