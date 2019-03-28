import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

var BASE_URL = "http://soupu.yuner.fun/app/";
var TOKEN_SP_KEY = "token";
var TOKEN_HEADER_KEY = "token";
var dio = new Dio(
    BaseOptions(baseUrl: BASE_URL, connectTimeout: 5000, receiveTimeout: 5000));

class NetUtils {
  static Future get(String url, {Map<String, dynamic> params}) async {
    Options options = await getHttpOptions();
    var response =
        await dio.get(url, queryParameters: params, options: options);
    return response.data;
  }

  static Future post(String url, String data) async {
    Options options = await getHttpOptions();
    var response = await dio.post(url, data: data, options: options);
    return response.data;
  }

  static Future getHttpOptions() async {
    String token = await getToken();
    Map<String, dynamic> headers = new Map();
    headers[TOKEN_HEADER_KEY] = token;
    Options options = Options(headers: headers);
    return options;
  }

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
