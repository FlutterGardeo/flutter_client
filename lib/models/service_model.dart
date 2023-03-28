class ServiceModel {
  String? id;
  String? name;
  String? description;
  ServiceModel({this.id, this.name, this.description});
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
    };
  }

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }
}
