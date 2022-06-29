// To parse this JSON data, do
//
//     final staffDetailModel = staffDetailModelFromJson(jsonString);

import 'dart:convert';

StaffDetailModel staffDetailModelFromJson(String str) => StaffDetailModel.fromJson(json.decode(str));

String staffDetailModelToJson(StaffDetailModel data) => json.encode(data.toJson());

class StaffDetailModel {
  StaffDetailModel({
    this.id,
    this.name,
    this.firstName,
    this.sex,
    this.email,
    this.phoneNumber,
    this.profileImage,
    this.bio,
    required this.rating,
    this.status,
    this.cleanProperty,
    this.bookingStatus,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? firstName;
  String? sex;
  String? email;
  int? phoneNumber;
  String? profileImage;
  dynamic? bio;
  int rating;
  String? status;
  List<dynamic>? cleanProperty;
  String? bookingStatus;
  dynamic? comment;
  dynamic? createdAt;
  dynamic? updatedAt;

  factory StaffDetailModel.fromJson(Map<String, dynamic> json) => StaffDetailModel(
    id: json["id"],
    name: json["name"],
    firstName: json["first_name"],
    sex: json["sex"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    profileImage: json["profile_image"],
    bio: json["bio"],
    rating: json["rating"],
    status: json["status"],
    cleanProperty: List<dynamic>.from(json["clean_property"].map((x) => x)),
    bookingStatus: json["booking_status"],
    comment: json["comment"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "first_name": firstName,
    "sex": sex,
    "email": email,
    "phone_number": phoneNumber,
    "profile_image": profileImage,
    "bio": bio,
    "rating": rating,
    "status": status,
    "clean_property": List<dynamic>.from(cleanProperty!.map((x) => x)),
    "booking_status": bookingStatus,
    "comment": comment,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
