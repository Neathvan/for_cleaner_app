// To parse this JSON data, do
//
//     final scheduleStaff = scheduleStaffFromJson(jsonString);

import 'dart:convert';

import 'package:clean_app/model/search_staff_model.dart';

ScheduleStaff scheduleStaffFromJson(String str) => ScheduleStaff.fromJson(json.decode(str));

String scheduleStaffToJson(ScheduleStaff data) => json.encode(data.toJson());

class ScheduleStaff {
  ScheduleStaff({
    this.id,
    this.schedualeId,
    this.staffId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.scheduleInfor,
  });

  int? id;
  int? schedualeId;
  int? staffId;
  String? status;
  String? createdAt;
  String? updatedAt;
  ScheduleInfor? scheduleInfor;

  factory ScheduleStaff.fromJson(Map<String, dynamic> json) => ScheduleStaff(
    id: json["id"],
    schedualeId: json["scheduale_id"],
    staffId: json["staff_id"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    scheduleInfor: ScheduleInfor.fromJson(json["schedule_infor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "scheduale_id": schedualeId,
    "staff_id": staffId,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "schedule_infor": scheduleInfor!.toJson(),
  };
}

class ScheduleInfor {
  ScheduleInfor({
    this.id,
    this.date,
    this.timeId,
    this.createdAt,
    this.updatedAt,
    this.times,
  });

  int? id;
  String? date;
  int? timeId;
  String? createdAt;
  String? updatedAt;
  Time? times;

  factory ScheduleInfor.fromJson(Map<String, dynamic> json) => ScheduleInfor(
    id: json["id"],
    date: json["date"],
    timeId: json["time_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    times:  Time.fromJson(json["times"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "time_id": timeId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "times": times!.toJson(),
  };
}


