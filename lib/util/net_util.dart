import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:score_app/bean/base_response.dart';
import 'package:score_app/util/token_util.dart';

//192.168.0.103 soupu.yuner.fun
var BASE_URL = "http://192.168.0.103:8080/app/";
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

  static Future post(String url, data, {Map<String, dynamic> params}) async {
    Options options = await getHttpOptions();
    var response = await dio.post(
        url, queryParameters: params,
        data: data == null ? null : json.encode(data),
        options: options);
    return response.data;
  }

  static Future delete(String url, {Map<String, dynamic> params}) async {
    Options options = await getHttpOptions();
    var response =
    await dio.delete(url, queryParameters: params, options: options);
    return response.data;
  }


  ///通过HttpOptions封装Http Header
  static Future getHttpOptions() async {
    dio.interceptors.add(new LogInterceptor());
    dio.interceptors.add(new InterceptorsWrapper(onResponse: (response) {
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.code != 1) {
        Fluttertoast.showToast(msg: baseResponse.message);
        if (baseResponse.code == 4) {
          return Future.error(baseResponse.message);
        }
      }
    }));

    String token = await TokenUtil.getToken();
    Map<String, dynamic> headers = new Map();
    headers[TOKEN_HEADER_KEY] = token;
    Options options = Options(headers: headers);
    return options;
  }


}
