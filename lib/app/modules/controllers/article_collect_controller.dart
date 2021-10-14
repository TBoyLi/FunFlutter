import 'package:fun_flutter/app/base/controllers/base_refresh_controller.dart';
import 'package:fun_flutter/app/modules/controllers/user_controller.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';
import 'package:get/get.dart';

class ArticleCollectController extends BaseRefeshController {
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
    return await WanApi.fetchCollectList(pageNum ?? 0);
  }
}
