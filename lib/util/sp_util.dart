import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static Future setString(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(key, value);
  }

  static Future getString(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }
}
