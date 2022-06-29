import 'package:clean_app/const/api_constant.dart';
import 'package:clean_app/repository/auth/user_repository.dart';
import 'package:clean_app/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  ApiRequest api = ApiRequest();
  ResponseChecking responseChecking = ResponseChecking();
  ApiConstants endpointConstants     = ApiConstants();
  final Future<SharedPreferences> preference = SharedPreferences.getInstance();
}

enum ApiStatus {
  error,
  loading,
  empty,
  connectionError,
  loaded
}

enum AuthState{
  unkown,loggedIn,loggedOut
}