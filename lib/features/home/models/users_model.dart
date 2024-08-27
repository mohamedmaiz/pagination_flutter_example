class UserModel {
  String? title;
  String? avatar;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  Adress? address;
  bool? isActive;
  int? id;
  UserModel({
    required this.id,
    required this.avatar,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.address,
    required this.isActive,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] as int?;
    title = json["title"] ?? '';
    avatar = json["avatar"] ?? '';
    firstName = json["first_name"] ?? '';
    lastName = json["last_name"] ?? '';
    email = json["email"] ?? '';
    gender = json["gender"] ?? '';
    json["address"] != null ? address = Adress.fromJson(json['address']) : null;
    isActive = json["is_active"] ?? false;
  }
}

class Adress {
  String? country;
  String? city;
  String? streetName;
  String? streetAddress;
  Adress(this.country, this.city, this.streetName, this.streetAddress);
  Adress.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    streetName = json['street_name'];
    streetAddress = json['street_address'];
  }
}
