import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    ResponseData respData = ResponseData.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;
      return handler.next(response);
    } else {
      throw ResultException.fromRespData(respData);
    }
  }
}

class ResponseData {
  int code = 0;
  String? message;
  dynamic data;

  bool get success => code == 0;

  ResponseData.fromJson(Map<String, dynamic> json) {
    message = json['errorMsg'];
    code = json['errorCode'];
    data = json['data'];
  }
}

/// 接口的code没有返回为true的异常
class ResultException implements Exception {
  int? code;
  String? message;

  ResultException.fromCodeMessage(this.code, this.message);

  ResultException.fromRespData(ResponseData respData) {
    code = respData.code;
    message = respData.message;
  }

  @override
  String toString() {
    return 'NotExpectedException -> code: $code, message: $message';
  }
}
