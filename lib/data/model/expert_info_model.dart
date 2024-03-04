
import 'package:consultancy/data/model/category_name_model.dart';
import 'package:consultancy/data/model/day_model.dart';
import 'package:consultancy/data/model/experiences_model.dart';

class ExpertInfoModel {

  int? id;
  String? name;
  String? phoneNumber;
  String? rememberToken;
  String? address;
  String? photo;
  int? money;
  double? rating;
  int? ratingNumber;
  String? startWork;
  String? endWork;
  Category? category;
  List<Experience>? experiences;
  List<Day>? workDays;

  ExpertInfoModel(
      {this.id,
        this.name,
        this.phoneNumber,
        this.rememberToken,
        this.address,
        this.photo,
        this.money,
        this.rating,
        this.ratingNumber,
        this.startWork,
        this.endWork,
        this.category,
        this.experiences,
        this.workDays});

  ExpertInfoModel.fromJson(Map<String, dynamic> json,lang) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    rememberToken = json['remember_token'];
    address = json['address'];
    photo = json['photo'];
    money = json['money'];
    rating = double.parse('${json['rating']}');
    ratingNumber = json['rating_number'];
    startWork = json['start_work'];
    endWork = json['end_work'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
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
