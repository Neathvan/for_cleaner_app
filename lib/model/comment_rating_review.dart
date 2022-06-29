// To parse this JSON data, do
//
//     final commentRatingReview = commentRatingReviewFromJson(jsonString);

import 'dart:convert';

import 'package:clean_app/model/user_model.dart';

CommentRatingReview commentRatingReviewFromJson(String str) => CommentRatingReview.fromJson(json.decode(str));

String commentRatingReviewToJson(CommentRatingReview data) => json.encode(data.toJson());

class CommentRatingReview {
  CommentRatingReview({
    this.id,
    this.userId,
    this.staffId,
    this.bookingId,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? userId;
  int? staffId;
  int? bookingId;
  int? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;
  UserModel? user;

  factory CommentRatingReview.fromJson(Map<String, dynamic> json) => CommentRatingReview(
    id: json["id"],
    userId: json["user_id"],
    staffId: json["staff_id"],
    bookingId: json["booking_id"],
    rating: json["rating"],
    comment: json["comment"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    user: UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "staff_id": staffId,
    "booking_id": bookingId,
    "rating": rating,
    "comment": comment,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user": user!.toJson(),
  };
}
