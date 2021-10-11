import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
// import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:fun_flutter/app/net/interceptor/api_interceptor.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'base_list_controller.dart';

abstract class BaseRefeshController<T> extends BaseListController<T> {
  /// 分页第一页页码
  static const int pageZero = 0;

  /// 分页条目数量
  static const int pageSize = 20;

  /// 当前页码
  int _currentPageNum = pageZero;

  final EasyRefreshController _refreshController = EasyRefreshController();
  EasyRefreshController get refreshController => _refreshController;

  // final RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  // RefreshController get refreshController => _refreshController;

  /// 下拉刷新
  ///
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  @override
  void onRefresh({bool init = false}) async {
    try {
      _currentPageNum = pageZero;
      var data = await loadData(pageNum: pageZero);
      if (data.isEmpty) {
        _refreshController.finishRefresh(noMore: true);
        // refreshController.refreshCompleted(resetFooterState: true);
        list.clear();
        loadState = LoadState.kEmpty;
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        _refreshController.finishRefresh();
        // refreshController.refreshCompleted();
        loadState = LoadState.kDone;
      }
      update();
      // return data;
    } catch (error, stackTrace) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (init) list.clear();
      _refreshController.finishRefresh();
      // refreshController.refreshFailed();
      if (error is ResultException) {
        errorMessage = error.message ?? 'status_unkown_error'.tr;
        if (error.code == -1001) {
          loadState = LoadState.kLogin;
        }
      } else {
        errorMessage = error.toString();
      }
      loadState = LoadState.kFailure;
      update();
      debugPrint('error--->\n' + error.toString());
      debugPrint('statck--->\n' + stackTrace.toString());
      // return null;
    }
  }

  /// 上拉加载更多
  void onLoad() async {
    try {
      var data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        refreshController.finishLoad(noMore: true);
        // refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < pageSize) {
          refreshController.finishLoad(noMore: true);
          // refreshController.loadNoData();
        } else {
          refreshController.finishLoad();
          // refreshController.loadComplete();
        }
      }
      update();
    } catch (e, s) {
      _currentPageNum--;
      refreshController.finishLoad(success: false);
      // refreshController.loadFailed();
      update();
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      return null;
    }
  }

  // 加载数据
  Future<List<T>> loadData({int? pageNum});

  @override
  void onClose() {
    _refreshController.dispose();
    super.onClose();
  }
}
