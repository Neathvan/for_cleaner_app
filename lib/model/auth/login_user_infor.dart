import 'dart:convert';

LoginUserInfor loginUserInforFromJson(String str) => LoginUserInfor.fromJson(json.decode(str));

String loginUserInforToJson(LoginUserInfor data) => json.encode(data.toJson());

class LoginUserInfor {
  LoginUserInfor({
    required this.token,
    required this.name,
  });

  String token;
  String name;

  factory LoginUserInfor.fromJson(Map<String, dynamic> json) => LoginUserInfor(
    token: json["token"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "name": name,
  };
}
