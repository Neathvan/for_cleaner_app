import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:clean_app/service/service.dart';

const baseUrl = "http://192.168.1.108:8000";
// const hostspot = "http://172.20.10.4:8000";

class WebUtil {
  static Dio createDio() {
    var dio = Dio(
        BaseOptions(
            baseUrl: baseUrl,
            headers: {
              "Accept": "application/json",
            },
            receiveDataWhenStatusError: true,
            connectTimeout: 100000, // 60 seconds
            receiveTimeout: 100000 // 60 seconds
        )
    );

    dio.interceptors.add(
        LogInterceptor(
          requestHeader: true,
          request: true,
          requestBody: true,
          responseHeader: false,
        ));

    return dio;
  }
}

class ApiRequest {

  Response _getResponseError(Object e) {
    if (e is DioError) {
      log('______status_code______${e.response?.statusCode}___');
      DioError de = e;
      if (de.response == null) {
        return Response(
          requestOptions: de.requestOptions,
          statusCode: -1,
          statusMessage: de.message,
        );
      }
      return e.response!;
    }
    return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: -999,
        statusMessage: e.toString());
  }


  Future post(String path, Map<String, dynamic> params) async {
    try {
      Response response = await WebUtil.createDio().post(path, data: params);
      log("Response ::: ${response.data}");
      return response;
    } catch (e) {
      log('_________________ERROR______________________');
      // ignore: unnecessary_type_check
      if (params is Map) log(jsonEncode(params));
      if (params is FormData) log(params.toString());
      return _getResponseError(e);
    }
  }


  Future postWithHeader(String path, Map<String, dynamic>? params, Map<String, dynamic> header) async {
    try {
      Response response = await WebUtil.createDio().post(path, data: params, options: Options(
          headers: header,
      ),);
      log("Response ::: $response");
      return response;
    } catch (e) {
      log('_________________ERROR______________________');
      // ignore: unnecessary_type_check
      if (params is Map) log(jsonEncode(params));
      if (params is FormData) log(params.toString());
      return _getResponseError(e);
    }
  }

}


class DioInterceptor extends Interceptor {

}
