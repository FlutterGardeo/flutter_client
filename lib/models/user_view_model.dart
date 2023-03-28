class UserViewModel {
  String? id;
  String? userName;

  UserViewModel({
    this.id,
    this.userName,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
    };
  }

  UserViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
  }
}
