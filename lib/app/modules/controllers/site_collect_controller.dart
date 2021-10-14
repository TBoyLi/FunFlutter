import 'package:flutter/material.dart';
import 'package:fun_flutter/app/base/controllers/base_list_controller.dart';
import 'package:fun_flutter/app/modules/controllers/user_controller.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';
import 'package:get/get.dart';

class SiteCollectController extends BaseListController {
  @override
  void onInit() {
    super.onInit();
    initData();
    UserController userController = Get.find<UserController>();
    ever(userController.hasUser, (bool hasUser) {
      if (hasUser) {
        initData();
      }
    });
  }

  @override
  Future<List> loadData({int? pageNum}) async {
    debugPrint('加载数据 => loadData');
    return await WanApi.fetchCollectSiteList();
  }
}
