import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:clean_app/model/response_data.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository extends Repository {

  Future login(String email, String password) async{
    var param = {
      "email" : email,
      "password": password
    };
    Response response = await api.post("/api/login", param );
    return ResponseChecking().kResponseChecking(response);
  }

  Future register(String name, String email, String password, String repwd)  async{
    var param = {
      "name":name,
      "email":email,
      "password":password,
      "c_password":repwd
    };
    Response response = await api.post("/api/register", param );
    return ResponseChecking().kResponseChecking(response);
  }

  Future logout(String token) async{
    var header = {
      "Authorization" : "Bearer $token",
    };
    Response response = await api.postWithHeader("/api/logout", {}, header );
    return ResponseChecking().kResponseChecking(response);
  }

  Future getUserInformation(String token) async{
    var header = {
      "Authorization" : "Bearer $token",
    };

    Response response = await api.postWithHeader("/api/view/profile", {}, header );
    return ResponseChecking().kResponseChecking(response);
  }
}

class ResponseChecking {
  
  kResponseChecking(Response response) async{
    ApiStatus status = await kCheckStatusResponse(response);
    return KData(response: responseDataFromJson(response.toString()), status: status);
  }

  kCheckStatusResponse(Response response ) {
    if( response.statusCode == 200 ) {

      return ApiStatus.loaded;
    }
    else if( response.statusCode == 400 ) {
      return ApiStatus.error;
    }
    else {
      return ApiStatus.connectionError;
    }
  }
}

