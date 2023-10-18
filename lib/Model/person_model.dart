// ignore_for_file: file_names

class PersonModel {
  String objectId = "";
  String name = "";
  String imagePath = "";
  String address = "";
  String? createdAt = "";
  String? updatedAt = "";

  PersonModel(
      {required this.name,
      required this.imagePath,
      required this.address,
      this.createdAt,
      this.updatedAt});

  PersonModel.create(this.name, this.imagePath, this.address);

  PersonModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['name'];
    imagePath = json['imagePath'];
    address = json['address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['name'] = name;
    data['imagePath'] = imagePath;
    data['address'] = address;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imagePath'] = imagePath;
    data['address'] = address;
    return data;
  }
}
