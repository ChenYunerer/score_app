import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:score_app/util/token_util.dart';

var BASE_URL = "http://soupu.yuner.fun:8080/app/";
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

  static void post(String url, data) async {
    Options options = await getHttpOptions();
    dio.post(url, data: data, options: options).then(
        handleResponse, onError: handleError);
  }

  static void handleResponse(Response response) {

  }

  static void handleError(DioError error) {
    Fluttertoast.showToast(
      msg: error.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
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
