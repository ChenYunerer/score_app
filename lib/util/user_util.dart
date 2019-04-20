import 'dart:convert';

import 'package:score_app/bean/user_info_bean.dart';
import 'package:shared_preferences/shared_preferences.dart';

var USER_SP_KEY = "user_info";

class UserUtil {
  static Future getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userInfoJsonStr = sp.get(USER_SP_KEY);
    if (userInfoJsonStr == null || userInfoJsonStr.isEmpty) {
      return null;
    }
    Map map = json.decode(userInfoJsonStr);
    return UserInfo.fromJson(map);
  }

  static Future saveUserInfo(UserInfo userInfo) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(USER_SP_KEY, json.encode(userInfo.toJson()));
  }

  static clearUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(USER_SP_KEY, "");
  }
}
