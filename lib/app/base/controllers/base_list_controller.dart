import 'package:flutter/material.dart';
import 'package:fun_flutter/app/base/controllers/base_controller.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:fun_flutter/app/net/interceptor/api_interceptor.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

abstract class BaseListController<T> extends BaseController {
  /// 页面数据
  List<T?> list = [];

  /// 第一次进入页面loading skeleton
  initData() async {
    loadState = LoadState.kLoading;
    onRefresh(init: true);
  }

  // 下拉刷新
  void onRefresh({bool init = false}) async {
    try {
      var data = await loadData();
      if (data.isEmpty) {
        list.clear();
        loadState = LoadState.kEmpty;
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        loadState = LoadState.kDone;
      }
      update();
      // return data;
    } catch (error, stackTrace) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (init) list.clear();
      if (error is ResultException) {
        errorMessage = error.message ?? 'status_unkown_error'.tr;
        if (error.code == -1001) {
          loadState = LoadState.kLogin;
        }
      } else {
        errorMessage = error.toString();
        loadState = LoadState.kFailure;
      }
      update();
      debugPrint('error--->\n' + error.toString());
      debugPrint('statck--->\n' + stackTrace.toString());
      // return null;
    }
  }

  // 加载数据
  Future<List<T?>> loadData();

  onCompleted(List<T?> data) {}
}
