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
      List<T?> data = await loadData();
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
    } catch (error, stackTrace) {
      if (init) list.clear();
      loadState = LoadState.kFailure;
      if (error is ResultException) {
        errorMessage = error.message ?? 'status_unkown_error'.tr;
      }
      update();
      debugPrint('error--->\n' + error.toString());
      debugPrint('statck--->\n' + error.toString());
    }
  }

  // 加载数据
  Future<List<T?>> loadData();

  onCompleted(List<T?> data) {}
}
