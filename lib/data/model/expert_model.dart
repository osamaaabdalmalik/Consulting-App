
class ExpertModel {

  int? id;
  String? name;
  String? photo;
  double? rating;
  String? phoneNumber;
  String? address;

  ExpertModel(
      {this.id, this.name, this.photo, this.rating, this.phoneNumber, this.address});

  ExpertModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    rating = double.parse(json['rating'].toString());
    phoneNumber = json['phone_number'];
    address = json['address'];
  }
}

class UserModel {
  int? id;
  String? name;
  String? photo;
  String? phoneNumber;

  UserModel(
      {this.id, this.name, this.photo,  this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    phoneNumber = json['phone_number'];
  }
}