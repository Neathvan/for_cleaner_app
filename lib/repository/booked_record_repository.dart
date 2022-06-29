import 'package:dio/dio.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookedRecordRepository extends Repository {

  Future getBookedRecord() async {
    final SharedPreferences prefs = await preference;

    String? token = prefs.getString("token");
    var header = {
      "Authorization" : "Bearer $token",
    };
    Response response = await api.postWithHeader("/api/booked/record", {}, header );
    return responseChecking.kResponseChecking(response);
  }

  Future getBookedRecordById(int id) async {
    final SharedPreferences prefs = await preference;

    String? token = prefs.getString("token");
    var header = {
      "Authorization" : "Bearer $token",
    };
    Response response = await api.postWithHeader("/api/booked/record/id", {'id' : id}, header );
    return responseChecking.kResponseChecking(response);
  }

  Future insertRating(int id,int bookingId,int rating, {String? comment}) async {
    final SharedPreferences prefs = await preference;

    String? token = prefs.getString("token");
    var header = {
      "Authorization" : "Bearer $token",
    };

    var param = {
      "staff_id"  : id,
      "rating"    : rating,
      "comment"   : comment,
      "booking_id": bookingId
    };
    Response response = await api.postWithHeader("/api/rating/review", param, header );
    return responseChecking.kResponseChecking(response);
  }
}