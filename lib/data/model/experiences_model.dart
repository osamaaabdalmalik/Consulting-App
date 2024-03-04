
class Experience {
  String? name;

  Experience({this.name});

  Experience.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}