
import 'package:consultancy/data/datasource/static/user_home_data.dart';

class Category {
  String? name;
  Category({this.name});

  Category.fromJson(Map<String, dynamic> json) {
    name = UserHomeData.lang == 'ar' ? json['name_ar'] : json['name_en'];
  }
}