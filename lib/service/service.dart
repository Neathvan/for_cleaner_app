import 'package:dio/dio.dart';
import 'package:clean_app/model/response_data.dart';
import 'package:clean_app/service/api.dart';

class BaseUrl {
  final apiUrl  = "http://localhost:8000";

}


class ApiProvider {
  final Dio dio = Dio(
      BaseOptions(
          connectTimeout: 5000,
          receiveTimeout: 5000,
          baseUrl: "http://127.0.0.1:8080",
      )
  );

  final String _url = 'https://api.covid19api.com/summary';

  var param = {
    "name":"neathh",
    "email":"neath@mail.com",
    "password":123456,
    "c_password":123456
  };

}