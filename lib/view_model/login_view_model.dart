import 'dart:developer';

import 'package:task/model/login_response.dart';
import 'package:task/repository/authentication_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task/utils/shared_preference.dart';

class LoginViewModel {
  final String _tag = "LoginViewModel";

  //Singleton
  static final LoginViewModel instance = LoginViewModel._privateConstructor();

  //Private constructor
  LoginViewModel._privateConstructor();

  final SharedPrefsHandler _sharedPrefsHandler = SharedPrefsHandler.instance;
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository.instance;
  final BehaviorSubject<LoginResponse?> _loginResponseBehaviorSubject = BehaviorSubject<LoginResponse?>();

  void login(String email, String password) async {
    LoginResponse? loginResponse = await _authenticationRepository.login(email, password);
    log(loginResponse.toString(), name: "$_tag login loginResponse");
    //Usually we check whether the token is null
    if (loginResponse.data != null) {
      if (loginResponse.message!.toLowerCase().contains("login success")) {
        _loginResponseBehaviorSubject.add(loginResponse);
        _sharedPrefsHandler.saveUserLoginInfo(email, password);
      }
    } else {
      _loginResponseBehaviorSubject.addError(loginResponse);
      log(loginResponse.toString(), name: "$_tag login ErrorResponse");
      _loginResponseBehaviorSubject.add(null);
    }
  }

  void logout() {
    _sharedPrefsHandler.clearAllData();
  }

  void dispose() {
    _loginResponseBehaviorSubject.add(null);
  }

  BehaviorSubject<LoginResponse?> get loginResponseBehaviorSubject => _loginResponseBehaviorSubject;
}
