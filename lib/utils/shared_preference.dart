import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHandler {
  static const String emailKey = "email";
  static const String passwordKey = "Password";

  static final SharedPrefsHandler instance = SharedPrefsHandler._privateConstructor();

  SharedPreferences? _preferences;

  SharedPrefsHandler._privateConstructor() {
    SharedPreferences.getInstance().then((value) => _preferences = value);
  }

  Future<bool?> saveUserLoginInfo(String email, String password) async {
    bool? mail = await _preferences?.setString(emailKey, email);
    bool? pass = await _preferences?.setString(passwordKey, password);
    if (mail == null || pass == null) {
      return null;
    } else {
      return mail || pass;
    }
  }

  String? getString(String key) {
    return _preferences?.getString(key);
  }

  void clearAllData() {
    _preferences?.clear();
  }
}