class UserViewModel {
  String? id;
  String? userName;
  String? email;

  UserViewModel({
    this.id,
    this.userName,
    this.email,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
    };
  }

  UserViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
  }
}
