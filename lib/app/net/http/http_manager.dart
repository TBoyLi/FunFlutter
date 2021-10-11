import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:fun_flutter/app/net/interceptor/api_interceptor.dart';
import 'package:fun_flutter/app/net/interceptor/cache_interceptor.dart';
import 'package:path_provider/path_provider.dart';

const String HOST = 'https://www.wanandroid.com/';

class HttpManager {
  Dio? _dio;

  factory HttpManager() => _getInstance();
  static HttpManager get instance => _getInstance();
  static HttpManager? _instance;

  static const int TIME_OUT = 30000;
  static PersistCookieJar? _cookieJar;

  //构造方法私有化
  HttpManager._() {
    BaseOptions options = BaseOptions(
        baseUrl: HOST,
        sendTimeout: TIME_OUT,
        receiveTimeout: TIME_OUT,
        connectTimeout: TIME_OUT);
    _dio = Dio(options);
    //管理cookie
    _dio?.interceptors.add(CookieManager(_cookieJar!));
    //处理response
    _dio?.interceptors.add(ApiInterceptor());
    //加入缓存机制
    _dio?.interceptors.add(NetCacheInterceptor());
    if (kDebugMode) {
      _dio?.interceptors.add(LogInterceptor(responseBody: true));
    }
  }

  static HttpManager _getInstance() {
    return _instance ?? HttpManager._();
  }

  //初始化CookieJar
  static Future<void> initCookieJar() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    _cookieJar = PersistCookieJar(storage: FileStorage(appDocPath));
  }

  void addCookies(List<Cookie> cookies) async {
    await _cookieJar?.loadForRequest(Uri.parse(HOST));
  }

  static Future<void> clearCookie() async {
    await _cookieJar?.deleteAll();
  }

  Future get(
    String url, {
    Map<String, dynamic>? params,
    bool refresh = false,
    bool list = false,
    bool cacheDisk = false,
    bool noCache = !CACHE_ENABLED,
    String newUrl = "",
  }) async {
    Options options = Options(extra: {
      "list": list,
      "noCache": noCache,
      "cacheDisk": cacheDisk,
      "refresh": refresh,
      "newUrl": newUrl
    });
    try {
      Response? response =
          await _dio?.get(url, queryParameters: params, options: options);
      return response;
    } on DioError catch (e) {
      throw HttpDioError.handleError(e);
    }
  }

  Future post(String url, {dynamic params}) async {
    try {
      Response? response;
      if (params == null) {
        response = await _dio?.post(url);
      } else {
        response = await _dio?.post(url, queryParameters: params);
      }
      return response;
    } on DioError catch (e) {
      throw HttpDioError.handleError(e);
    }
  }

  Future postFormData(String url, Map<String, dynamic> params) async {
    try {
      Response? response =
          await _dio?.post(url, data: FormData.fromMap(params));
      return response?.data;
    } on DioError catch (e) {
      throw HttpDioError.handleError(e);
    }
  }
}

class HttpDioError {
  static const int LOGIN_CODE = -1001;

  static ResultException handleError(DioError dioError) {
    int? code = 9999;
    String? message = "未知错误";
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        code = 9000;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.receiveTimeout:
        code = 90001;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.sendTimeout:
        code = 90002;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.response:
        code = 90003;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.cancel:
        code = 90004;
        message = "请求已被取消，请重新请求";
        break;
      case DioErrorType.other:
        if (dioError.error is SocketException) {
          code = 90005;
          message = "网络异常，请稍后重试！";
        } else if (dioError.error is ResultException) {
          var exception = dioError.error as ResultException;
          code = exception.code;
          message = exception.message;
        }
        break;
    }
    return ResultException.fromCodeMessage(code, message);
  }
}
