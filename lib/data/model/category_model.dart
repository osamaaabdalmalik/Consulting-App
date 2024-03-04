
import 'package:consultancy/data/datasource/static/user_home_data.dart';

class CategoryModel{
  int? id;
  String? name;
  String? photo;

  CategoryModel({this.id, this.name, this.photo});

  CategoryModel.fromJson(Map<String, dynamic> json,String lang) {
    id = json['id'];

    name = UserHomeData.lang == 'ar' ? json['name_ar'] : json['name_en'];
    photo = json['photo'];
  }
}