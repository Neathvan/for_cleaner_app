
// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

List<Register> registerFromJson(String str) => List<Register>.from(json.decode(str).map((x) => Register.fromJson(x)));

String registerToJson(List<Register> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Register {
  Register({
    required this.id,
    required this.name,
    required this.email,
  });

  int id;
  String name;
  String email;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    id: json["id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
  };
}
