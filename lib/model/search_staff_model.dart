// To parse this JSON data, do
//
//     final searchStaff = searchStaffFromJson(jsonString);

import 'dart:convert';

SearchStaff searchStaffFromJson(String str) => SearchStaff.fromJson(json.decode(str));

String searchStaffToJson(SearchStaff data) => json.encode(data.toJson());

class SearchStaff {
  SearchStaff({
    this.id,
    this.date,
    this.timeId,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.staffInfo,
  });

  int? id;
  String? date;
  int? timeId;
  dynamic? createdAt;
  dynamic? updatedAt;
  Time? image;
  List<StaffInfo>? staffInfo;

  factory SearchStaff.fromJson(Map<String, dynamic> json) => SearchStaff(
    id: json["id"],
    date: json["date"],
    timeId: json["time_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    image: Time.fromJson(json["times"]),
    staffInfo: List<StaffInfo>.from(json["staff_info"].map((x) => StaffInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "time_id": timeId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "times": image!.toJson(),
    "staff_info": List<dynamic>.from(staffInfo!.map((x) => x.toJson())),
  };
}

class Time {
  Time({
    this.id,
    this.startTime,
    this.endTime,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? startTime;
  String? endTime;
  int? status;
  String? createdAt;
  String? updatedAt;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    id: json["id"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start_time": startTime,
    "end_time": endTime,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class StaffInfo {
  StaffInfo({
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
    this.pivot,
  });

  int? id;
  String? name;
  String? firstName;
  String? sex;
  String? email;
  int? phoneNumber;
  String? profileImage;
  dynamic bio;
  int? rating;
  String? status;
  List<dynamic>? cleanProperty;
  String? bookingStatus;
  dynamic? comment;
  dynamic? createdAt;
  dynamic? updatedAt;
  Pivot? pivot;

  factory StaffInfo.fromJson(Map<String, dynamic> json) => StaffInfo(
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
    pivot: Pivot.fromJson(json["pivot"]),
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
    "pivot": pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    this.schedualeId,
    this.staffId,
    this.status
  });

  int? schedualeId;
  int? staffId;
  String? status;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    schedualeId: json["scheduale_id"],
    staffId: json["staff_id"],
    status: json['status']
  );

  Map<String, dynamic> toJson() => {
    "scheduale_id": schedualeId,
    "staff_id": staffId,
    "status"  : status
  };
}
