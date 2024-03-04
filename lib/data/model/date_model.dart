
import 'package:consultancy/data/model/day_model.dart';

class DateModel {
  int? id;
  String? time;
  int? dayId;
  Day? day;

  DateModel({this.id, this.time, this.dayId, this.day});

  DateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    dayId = json['day_id'];
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
  }
}