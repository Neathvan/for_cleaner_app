import 'package:dio/dio.dart';
import 'package:clean_app/const/api_constant.dart';
import 'package:clean_app/repository/auth/user_repository.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchStaffRepository extends Repository {

  Future searchStaffByStartEndDate(String startDate, String endDate) async {
    final SharedPreferences prefs = await preference;

    String? token = prefs.getString("token");
    var header = {
      "Authorization" : "Bearer $token",
    };

    var params = {
      'start_date' : startDate,
      'end_date'    : endDate
    };

    Response response = await api.postWithHeader("/api/search/staff/by/start/end/date", params, header );
    return responseChecking.kResponseChecking(response);
  }

  Future viewScheduleStaff(int id) async {
    final SharedPreferences prefs = await preference;

    String? token = prefs.getString("token");
    var header = {
      "Authorization" : "Bearer $token",
    };

    var params = {
      'id' : id,
    };

    Response response = await api.postWithHeader("/api/view/staff/scheduale", params, header );
    return responseChecking.kResponseChecking(response);
  }
}