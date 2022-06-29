// To parse this JSON data, do
//
//     final responseData = responseDataFromJson(jsonString);

import 'dart:convert';

import 'package:clean_app/repository/repository.dart';

ResponseData responseDataFromJson(String str) => ResponseData.fromJson(json.decode(str));

String responseDataToJson(ResponseData data) => json.encode(data.toJson());

class ResponseData<T> {
  ResponseData({
    this.success,
     this.data,
     this.message,
  });

  bool? success;
  var data;
  String? message;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    success: json["success"],
    data: json['data'] is List ?  List<dynamic>.from(json["data"].map((x) => x)): json['data'],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data is List ? List<dynamic>.from(data.map((x) => x)) : data.toJson(),
    "message": message,
  };
}

class KData {
  KData({
    required this.response,
    required this.status,
  });

  ResponseData response;
  ApiStatus status;

  factory KData.fromJson(Map<String, dynamic> json) => KData(
    response: ResponseData.fromJson(json['data']),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
    "status": status,
  };
}
