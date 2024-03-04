
import 'package:consultancy/data/model/date_model.dart';

class UserBookingModel {
  int? id;
  Expert? expert;
  DateModel? date;

  UserBookingModel({this.id, this.expert, this.date});

  UserBookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expert = json['expert'] != null ? Expert.fromJson(json['expert']) : null;
    date = json['date'] != null ? DateModel.fromJson(json['date']) : null;
  }
}

class Expert {
  int? id;
  String? name;
  String? photo;

  Expert({this.id, this.name, this.photo});

  Expert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }
}
