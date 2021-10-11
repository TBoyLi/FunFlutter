import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fun_flutter/app/base/controllers/base_controller.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:get/get.dart';

class StateRefreshWidget<T extends BaseController> extends GetView<T> {
  const StateRefreshWidget({
    this.onPressed,
    this.onRefresh,
    this.onLoading,
    this.child,
    required this.refreshController,
    this.header,
    this.footer,
    this.failurePage,
    this.emptyPage,
    this.enablePullDown,
    this.enablePullUp,
    Key? key,
    // this.controller,
  }) : super(key: key);

  // final T? controller;
  final VoidCallback? onPressed;
  final OnRefreshCallback? onRefresh;
  final OnLoadCallback? onLoading;
  final Widget? child;
  final EasyRefreshController refreshController;
  final Header? header;
  final Footer? footer;
  final Widget? failurePage;
  final Widget? emptyPage;
  final bool? enablePullDown;
  final bool? enablePullUp;

  @override
  Widget build(BuildContext context) {
    /**
     * 在一个包含了大量对象的List，都使用响应式变量，将生成大量的GetStream，
     * 必将对内存造成较大的压力，该情况下，就要考虑使用简单状态管理了
     * 推荐GetBuilder和update配合的写法
     */
    return GetBuilder<T>(
      // init: controller,
      builder: (_) {
        if (controller.loadState == LoadState.kLoading) {
          return const LoadingListPage();
        } else if (controller.loadState == LoadState.kLogin) {
          return LoginErrorPage(
            // onPressed: onPressed,
            errorMeg: controller.errorMessage,
          );
        } else if (controller.loadState == LoadState.kFailure) {
          return failurePage ??
              NetWorkErrorPage(
                onPressed: onPressed,
                errorMeg: controller.errorMessage,
              );
        }
        return EasyRefresh(
          controller: refreshController,
          onRefresh: onRefresh,
          onLoad: onLoading,
          header: header ??
              ClassicalHeader(
                refreshText: 'easy_refresh_pullToRefresh'.tr,
                refreshReadyText: 'easy_refresh_releaseToRefresh'.tr,
                refreshingText: 'easy_refresh_refreshing'.tr,
                refreshedText: 'easy_refresh_refreshed'.tr,
                refreshFailedText: 'easy_refresh_refreshFailed'.tr,
                noMoreText: 'easy_refresh_noMore'.tr,
                infoText: 'easy_refresh_updateAt'.tr,
              ),
          footer: footer ??
              ClassicalFooter(
                loadText: 'easy_refresh_pushToLoad'.tr,
                loadReadyText: 'easy_refresh_releaseToLoad'.tr,
                loadingText: 'easy_refresh_loading'.tr,
                loadedText: 'easy_refresh_loaded'.tr,
                loadFailedText: 'easy_refresh_loadFailed'.tr,
                noMoreText: 'easy_refresh_noMore'.tr,
                infoText: 'easy_refresh_updateAt'.tr,
              ),
          emptyWidget: controller.loadState == LoadState.kEmpty
              ? EmptyPage(
                  onPressed: onPressed,
                )
              : null,
          child: child,
        );
      },
    );
  }
}
