class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  String? group;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.group,
  });

  setGroup(String? groupName) {
    group = groupName;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['sub'],
      email: json['email'],
      firstName: json['given_name'],
      lastName: json['family_name'],
    );
  }
}
