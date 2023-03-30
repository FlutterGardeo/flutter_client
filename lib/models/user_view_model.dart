class UserViewModel {
  String? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? accessToken;

  UserViewModel({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.accessToken,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "accessToken": accessToken,
    };
  }

  UserViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    accessToken = json['accessToken'];
  }
}
