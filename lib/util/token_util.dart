import 'package:shared_preferences/shared_preferences.dart';

var TOKEN_SP_KEY = "token";

class TokenUtil {
  static Future getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.get(TOKEN_SP_KEY);
  }

  static Future saveToken(String token) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(TOKEN_SP_KEY, token);
  }

  static clearToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(TOKEN_SP_KEY, "");
  }
}
