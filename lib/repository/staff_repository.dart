import 'package:dio/dio.dart';
import 'package:clean_app/const/api_constant.dart';
import 'package:clean_app/repository/auth/user_repository.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffRepository extends Repository {

  Future getStaffDetail(int id) async {
    final SharedPreferences prefs = await preference;

    String? token = prefs.getString("token");
    var header = {
      "Authorization" : "Bearer $token",
    };

    var params = {
      'id' : id,
    };

    Response response = await api.postWithHeader("/api/view/staff/detail", params, header );
    return responseChecking.kResponseChecking(response);
  }

  Future getCommentRatingReviewList(int id) async {
    final SharedPreferences prefs = await preference;

    String? token = prefs.getString("token");
    var header = {
      "Authorization" : "Bearer $token",
    };

    var params = {
      'id' : id,
    };

    Response response = await api.postWithHeader("/api/get/comment/list", params, header );
    return responseChecking.kResponseChecking(response);
  }


  Future getStaffList() async {
    final SharedPreferences prefs = await preference;

    String? token = prefs.getString("token");
    var header = {
      "Authorization" : "Bearer $token",
    };

    Response response = await api.postWithHeader("/api/employee/list", {}, header );
    return responseChecking.kResponseChecking(response);
  }
}