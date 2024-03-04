class UserInfo {

  int? id;
  String? name;
  String? phoneNumber;
  String? photo;
  int? money;
  String? rememberToken;

  UserInfo(
      {
        this.id,
        this.name,
        this.phoneNumber,
        this.photo,
        this.money,
        this.rememberToken});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    photo = json['photo'];
    money = json['money'];
    rememberToken = json['remember_token'];
  }
}