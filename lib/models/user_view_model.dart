class UserViewModel {
  String? id;
  String? userName;
  String? email;
  String? accessToken;

  UserViewModel({
    this.id,
    this.userName,
    this.email,
    this.accessToken,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "accessToken": accessToken,
    };
  }

  UserViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    accessToken = json['accessToken'];
  }
}
