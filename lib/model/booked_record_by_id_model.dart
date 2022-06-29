// To parse this JSON data, do
//
//     final bookedRecordByIdModel = bookedRecordByIdModelFromJson(jsonString);

import 'dart:convert';

import 'package:clean_app/model/booked_record_model.dart';

BookedRecordByIdModel bookedRecordByIdModelFromJson(String str) => BookedRecordByIdModel.fromJson(json.decode(str));

String bookedRecordByIdModelToJson(BookedRecordByIdModel data) => json.encode(data.toJson());

class BookedRecordByIdModel {
  BookedRecordByIdModel({
    this.id,
    this.name,
    this.firstName,
    this.sex,
    this.email,
    this.phoneNumber,
    this.profileImage,
    this.bio,
    this.rating,
    this.status,
    this.cleanProperty,
    this.bookingStatus,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.bookedRecord,
  });

  int? id;
  String? name;
  String? firstName;
  String? sex;
  String? email;
  int? phoneNumber;
  String? profileImage;
  dynamic? bio;
  int? rating;
  String? status;
  List<dynamic>? cleanProperty;
  String? bookingStatus;
  dynamic comment;
  dynamic createdAt;
  dynamic updatedAt;
  BookedRecordModel? bookedRecord;

  factory BookedRecordByIdModel.fromJson(Map<String, dynamic> json) => BookedRecordByIdModel(
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
    bookedRecord: BookedRecordModel.fromJson(json["booked_record"]),
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
    "booked_record": bookedRecord!.toJson(),
  };
}
