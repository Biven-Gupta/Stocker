import 'dart:developer';

import 'package:task/api/http_manager.dart';
import 'package:task/model/login_response.dart';

class AuthenticationRepository {
  final String _tag = "AuthenticationRepository";

  static final AuthenticationRepository instance = AuthenticationRepository._privateConstructor();

  AuthenticationRepository._privateConstructor();

  final HttpManager _httpManager = HttpManager.instance;

  Future<LoginResponse> login(String email, String password) async {
    LoginResponse? response = await _httpManager.login(email, password);
    log(response.toString(), name: "$_tag login response");
    if (response != null) {
      return response;
    } else {
      return LoginResponse();
    }
  }
}
