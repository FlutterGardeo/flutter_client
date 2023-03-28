class DeviceModel {
  String? id;
  String? name;
  String? description;
  String? manufacturer;
  String? imageUrl;
  double? price;

  DeviceModel({
    this.id,
    this.name,
    this.description,
    this.manufacturer,
    this.imageUrl,
    this.price,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "manufacturer": manufacturer,
      "imageUrl": imageUrl,
      "price": price,
    };
  }

  DeviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    manufacturer = json['manufacturer'];
    imageUrl = json['imageUrl'];
    price = json['price'];
  }
}
