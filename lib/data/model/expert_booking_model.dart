import 'package:consultancy/data/model/date_model.dart';

class ExpertBookingModel {
  int? id;
  User? user;
  DateModel? date;

  ExpertBookingModel({this.id, this.user, this.date});
  ExpertBookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    date = json['date'] != null ? DateModel.fromJson(json['date']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? photo;

  User({this.id, this.name, this.photo});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }
}
