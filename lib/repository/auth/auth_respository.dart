import 'package:dio/dio.dart';
import 'package:clean_app/model/response_data.dart';
import 'package:clean_app/service/api.dart';
import 'package:clean_app/service/service.dart';

class ApiRepository {
  final _provider = ApiRequest();
}

class NetworkError extends Error {}