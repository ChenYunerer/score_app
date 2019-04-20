import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:score_app/util/token_util.dart';

//192.168.0.107 soupu.yuner.fun
var BASE_URL = "http://192.168.0.102:8080/app/";
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

  static Future post(String url, data) async {
    Options options = await getHttpOptions();
    var response = await dio.post(
        url, data: json.encode(data), options: options);
    return response.data;
  }


  ///通过HttpOptions封装Http Header
  static Future getHttpOptions() async {
    String token = await TokenUtil.getToken();
    Map<String, dynamic> headers = new Map();
    headers[TOKEN_HEADER_KEY] = token;
    Options options = Options(headers: headers);
    return options;
  }


}
