
import 'package:consultancy/data/datasource/static/user_home_data.dart';

class Day {
  int? id;
  String? name;

  Day({this.id, this.name});

  Day.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = UserHomeData.lang== 'ar' ? json['name_ar'] : json['name_en'];
  }
}