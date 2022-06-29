// To parse this JSON data, do
//
//     final bookedRecordModel = bookedRecordModelFromJson(jsonString);

import 'dart:convert';

BookedRecordModel bookedRecordModelFromJson(String str) => BookedRecordModel.fromJson(json.decode(str));

String bookedRecordModelToJson(BookedRecordModel data) => json.encode(data.toJson());

class BookedRecordModel {
  BookedRecordModel({
    this.id,
    this.userId,
    this.startTime,
    this.endTime,
    this.date,
    this.status,
    this.name,
    this.phoneNumber,
    this.nationality,
    this.gender,
    this.staffId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? startTime;
  String? endTime;
  String? date;
  String? status;
  String? name;
  String? phoneNumber;
  String? nationality;
  dynamic? gender;
  int? staffId;
  String? createdAt;
  String? updatedAt;

  factory BookedRecordModel.fromJson(Map<String, dynamic> json) => BookedRecordModel(
    id: json["id"],
    userId: json["user_id"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    date: json["date"],
    status: json["status"],
    name: json["name"],
    phoneNumber: json["phone_number"] != null ? json["phone_number"].toString() : 'N/A',
    nationality: json["nationality"] != null ? json["nationality"].toString() : 'N/A',
    gender: json["gender"],
    staffId: json["staff_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "start_time": startTime,
    "end_time": endTime,
    "date": date,
    "status": status,
    "name": name,
    "phone_number": phoneNumber,
    "nationality": nationality,
    "gender": gender,
    "staff_id": staffId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
