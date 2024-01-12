import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:task/api/api_url.dart';
import 'package:task/model/home_response.dart';
import 'package:task/model/item_list.dart';
import 'package:task/model/login_response.dart';
import 'package:task/utils/utils.dart';

class HttpManager {
  final String _tag = "HttpManager";
  late Dio _dio;

  static final HttpManager instance = HttpManager._privateConstructor();

  HttpManager._privateConstructor() {
    _dio = Dio(BaseOptions(baseUrl: ""));
    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      log(options.data.toString(), name: "RequestInterceptorHandler");
      handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      log(response.data.toString(), name: "ResponseInterceptorHandler");
      handler.next(response);
    }, onError: (DioException error, ErrorInterceptorHandler handler) {
      log(error.error.toString(), name: "ErrorInterceptorHandler error");
      log(error.response.toString(), name: "ErrorInterceptorHandler response");
      log(error.message.toString(), name: "ErrorInterceptorHandler message");
      log(error.stackTrace.toString(), name: "ErrorInterceptorHandler stackTrace");
      handler.next(error);
    }));
  }

  dynamic errorHandler(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
      case DioExceptionType.connectionError:
        return error.message;
      case DioExceptionType.badResponse:
        return error.response?.data;
      case DioExceptionType.cancel:
        return "Cancelled";
    }
  }

  Future<LoginResponse?> login(String email, String password) async {
    try {
      Response<Map<String, dynamic>> response = await _dio.post<Map<String, dynamic>>(ApiUrl.loginUrl, data: FormData.fromMap({"email": email, "password": password}));
      log(response.toString(), name: "$_tag login response");
      LoginResponse loginResponse = LoginResponse.fromJson(response.data!);
      return loginResponse;
    } on DioException catch (_, e) {
      dynamic msg = await errorHandler(e as DioException);
      log(msg.toString(), name: "$_tag login error msg");
      if (msg is String) {
        log("true", name: "$_tag login error msg is String");
        return LoginResponse(message: msg);
      } else if (msg is Map<String, dynamic>) {
        log("true", name: "$_tag login error msg is Map");
        return LoginResponse.fromJson(msg);
      } else {
        log("true", name: "$_tag login error msg is unknown");
        log(msg.toString(), name: "$_tag login error msg is unknown");
      }
    }
    return null;
  }

  Future<ItemList?> content() async {
    try {
      final response = await _dio.get(ApiUrl.contentUrl, queryParameters: {"apikey": ApiUrl.contentApiKey});
      log(response.toString(), name: "$_tag content response");
      if (response.statusCode == 200) {
        log(response.toString(), name: "$_tag json response");

        // List<dynamic> jsonResponse = json.decode(response.data);
        return ItemList.fromJson(response.data);
      }
      // ItemList homeResponse = ItemList.fromJson(response);
      // return homeResponse;
    } on DioException catch (_, e) {
      dynamic msg = await errorHandler(e as DioException);
      log(msg.toString(), name: "$_tag content error msg");
      return null;
    }
    return null;
  }
}
