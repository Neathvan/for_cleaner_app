import 'package:dio/dio.dart';
import 'package:clean_app/repository/auth/user_repository.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingRepository extends Repository {
  Future getEmployeeList() async {
    final SharedPreferences prefs = await preference;

    String? token = prefs.getString("token");
    var header = {
      "Authorization" : "Bearer $token",
    };
    Response response = await api.postWithHeader("/api/employee/list", {}, header );
    return responseChecking.kResponseChecking(response);
  }

  Future bookingStaffCleanService(String date, String start, String end, String name, String? phoneNum, String nation,String? gender,  int staffId, int timeId,{ int? userId}) async {
    final SharedPreferences prefs = await preference;

    String? token = prefs.getString("token");
    var header = {
      "Authorization" : "Bearer $token",
    };

    var param = {
      "time_id"   : timeId,
    "date"        :date,
    "start_time"  :start,
    "staff_id"    :staffId,
    "name"        :name,
    "phone_number":phoneNum,
    "nationality": nation,
    "end_time"  :end,
      "gender"  : gender
    };
    Response response = await api.postWithHeader("/api/booking", param, header );
    return responseChecking.kResponseChecking(response);
  }
}