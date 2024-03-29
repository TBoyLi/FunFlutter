import 'package:flutter/material.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:fun_flutter/app/net/http/http_manager.dart';
import 'package:fun_flutter/app/net/interceptor/api_interceptor.dart';
import 'package:fun_flutter/app/routes/app_pages.dart';
import 'package:fun_flutter/app/utils/storage_manager.dart';
import 'package:fun_flutter/global.dart';
import 'package:get/get.dart';

typedef Success = Function(dynamic value);
typedef Failure = Function(dynamic value);
typedef Done = Function();

abstract class BaseController extends GetxController {
  LoadState loadState = LoadState.kDone;
  // int iniItemIndex = 0;

  //返回都错误结果
  // final exception = ResultException.fromCodeMessage(0, "null").obs;

  String errorMessage = 'tips_loading_error'.tr;

  @override
  void onInit() {
    super.onInit();
  }

  //局部刷新必须赋值id
  void fetch(
    Future<dynamic> future,
    bool isLoading, {
    required Success success,
    Failure? failure,
    Done? done,
    bool refreshItem = false,
    int id = 0,
  }) {
    if (isLoading) {
      loadState = LoadState.kLoading;
      refreshItem ? update([id]) : update();
    }
    future.then((value) {
      //请求数据成功，返回请求结果
      success(value);
      loadState = LoadState.kSuccess;
      refreshItem ? update([id]) : update();
    }).onError<ResultException>((error, stackTrace) async {
      //请求失败
      if (isLoading) {
        loadState = LoadState.kFailure;
        refreshItem ? update([id]) : update();
      }
      if (error.code == HttpDioError.LOGIN_CODE) {
        resetUser();
      }
      if (failure != null) {
        failure(error.message);
      }
      errorMessage = error.message ?? 'status_unkown_error'.tr;
      refreshItem ? update([id]) : update();
    });
  }

  void resetUser() {
    //重置用户信息
    StorageManager.localStorage.deleteItem(Global.kUser);
    //用户需要登录才能进行操作
    Get.defaultDialog(
      title: 'login'.tr,
      content: Text('tips_login'.tr),
      textConfirm: 'login'.tr,
      textCancel: 'cancel'.tr,
      onConfirm: () {
        Get.back();
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.toNamed(Routes.LOGIN);
        });
      },
      onCancel: () {},
    );
  }

  void showError(error) {
    Get.snackbar(
      'tips_error'.tr,
      error,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
