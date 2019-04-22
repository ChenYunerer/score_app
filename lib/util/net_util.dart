import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:score_app/bean/base_response.dart';
import 'package:score_app/util/toast_util.dart';
import 'package:score_app/util/token_util.dart';
import 'package:score_app/util/user_util.dart';

class NetUtils {
  //192.168.0.103 soupu.yuner.fun
  static var BASE_URL = "http://soupu.yuner.fun:8080/app/";
  static var TOKEN_HEADER_KEY = "token";
  static var dio = _init();
  static var netUtil = NetUtils._internal();

  NetUtils._internal();

  static NetUtils getInstance() {
    return netUtil;
  }

  static Dio _init() {
    var _dio = new Dio(new BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: 5000,
        receiveTimeout: 5000
    ));

    _dio.interceptors.add(new LogInterceptor());
    _dio.interceptors.add(new InterceptorsWrapper(onResponse: (response) {
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.code != 1) {
        ToastUtil.showToast(baseResponse.message);
        if (baseResponse.code == 4) {
          UserUtil.clearUserInfo();
          TokenUtil.clearToken();
          ToastUtil.showToast("请重新登录");
          return Future.error(baseResponse.message);
        }
      }
    }, onError: (e) {
      ToastUtil.showToast(e.message);
    }));

    return _dio;
  }

  Future get(String url, {Map<String, dynamic> params}) async {
    Options options = await getHttpOptions();
    var response =
        await dio.get(url, queryParameters: params, options: options);
    return response.data;
  }

  Future post(String url, data, {Map<String, dynamic> params}) async {
    Options options = await getHttpOptions();
    var response = await dio.post(
        url, queryParameters: params,
        data: data == null ? null : json.encode(data),
        options: options);
    return response.data;
  }

  Future delete(String url, {Map<String, dynamic> params}) async {
    Options options = await getHttpOptions();
    var response =
    await dio.delete(url, queryParameters: params, options: options);
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
