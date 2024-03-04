

import 'package:consultancy/data/model/category_name_model.dart';
import 'package:consultancy/data/model/day_model.dart';
import 'package:consultancy/data/model/experiences_model.dart';

class ExpertDetailsModel {

  int? id;
  String? name;
  String? phoneNumber;
  String? address;
  String? photo;
  double? rating;
  int? ratingNumber;
  String? startWork;
  String? endWork;
  Category? category;
  List<Experience>? experiences;
  List<Day>? workDays;

  ExpertDetailsModel({this.id, this.name, this.phoneNumber, this.address, this.photo, this.rating, this.ratingNumber, this.startWork, this.endWork, this.category, this.experiences, this.workDays});

  ExpertDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    photo = json['photo'];
    rating = double.parse(json['rating'].toString());
    ratingNumber = json['rating_number'];
    startWork = json['start_work'];
    endWork = json['end_work'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['experiences'] != null) {
      experiences = <Experience>[];
      json['experiences'].forEach((v) {
        experiences!.add(Experience.fromJson(v));
      });
    }
    if (json['work_days'] != null) {
      workDays = <Day>[];
      json['work_days'].forEach((v) {
        workDays!.add(Day.fromJson(v));
      });
    }
  }
}


