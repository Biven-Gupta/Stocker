import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/model/login_response.dart';
import 'package:task/utils/utils.dart';
import 'package:task/utils/widgets.dart';
import 'package:task/view_model/login_view_model.dart';
import 'package:task/views/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const _tag = "Login";

  final LoginViewModel _loginViewModel = LoginViewModel.instance;

  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();

  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  final double _emailElevation = 4;
  final double _passwordElevation = 6;
  bool _passwordVisible = false;
  bool _isLoading = false;

  StreamSubscription? _loginResponse;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginResponse = _loginViewModel.loginResponseBehaviorSubject.listen((LoginResponse? value) {
      log(value.toString(), name: "Login Results");
      if (value != null) {
        if (mounted) {
          setState(() => _isLoading = false);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const HomeScreen()));
        }
      }
    }, onError: (value) {
      log(value.toString(), name: "Login errors");
      LoginResponse error = value;
      setState(() => _isLoading = false);
      if (error.message != null) {
        log(error.message!, name: "$_tag initState response error.message != null");
        Utils.showErrorToast(context, message: error.message??"");
      } else {
        Utils.showErrorToast(context, message: "Something went wrong please try again");
      }
    });
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _focusNodeEmail.dispose();
    _loginResponse?.cancel();
    _loginViewModel.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("STOCKERS",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.w700,fontSize: 40),),
                  const SizedBox(width: 4),
                  SvgPicture.asset("assets/stock_up.svg"),
                ],
              ),
              const SizedBox(height: 20),
              _userEmailText(context), const SizedBox(height: 20), _userPasswordText(context), const SizedBox(height: 20), _loginButton(context)],
          ),
        ),
      ),
    );
  }

  bool checkInputValidation() {
    String emailText = emailTextEditingController.value.text;
    String passwordText = passwordTextEditingController.value.text;
    if (emailText.isEmpty) {
      Utils.showValidationToast(context, "Please enter your email!");
      FocusScope.of(context).requestFocus(_focusNodeEmail);
      return false;
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailText)) {
      Utils.showValidationToast(context, "Please enter valid email!");
      FocusScope.of(context).requestFocus(_focusNodePassword);
      return false;
    } else if (passwordText.isEmpty) {
      Utils.showValidationToast(context, "Please enter your password!");
      FocusScope.of(context).requestFocus(_focusNodePassword);
      return false;
    } else {
      return true;
    }
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      height: 50,
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(top: 15.0, bottom: 12.0),
          backgroundColor: Colors.deepOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () => _isLoading ? null : _handleLoginButtonClick(),
        child: _isLoading ? Widgets.isLoading(col: Colors.white) : const Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
      ),
    );
  }

  void _handleLoginButtonClick() {
    if (checkInputValidation()) {
      _loginViewModel.login(emailTextEditingController.text, passwordTextEditingController.text);
      setState(() => _isLoading = true);
    }
  }

  Widget _userEmailText(BuildContext context) {
    return Card(
      elevation: _emailElevation,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 10),
        child: TextFormField(
          controller: emailTextEditingController,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          onFieldSubmitted: (focus) {
            _focusNodeEmail.unfocus();
            FocusScope.of(context).requestFocus(_focusNodePassword);
          },
          focusNode: _focusNodeEmail,
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          decoration: const InputDecoration(
            hintText: "Email",
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _userPasswordText(BuildContext context) {
    return Card(
      elevation: _passwordElevation,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 10, right: 4),
        child: TextFormField(
          controller: passwordTextEditingController,
          keyboardType: TextInputType.text,
          focusNode: _focusNodePassword,
          onFieldSubmitted: (focus) {
            _focusNodePassword.unfocus();
            _handleLoginButtonClick();
          },
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.go,
          obscureText: !_passwordVisible,
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: "Password",
            filled: true,
            fillColor: Colors.transparent,
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.deepOrange,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
