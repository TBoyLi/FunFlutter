import 'package:fun_flutter/app/base/controllers/base_controller.dart';
import 'package:fun_flutter/app/base/controllers/base_list_controller.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';

class WechatController extends BaseListController {
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  Future<List> loadData() async {
    return await WanApi.fetchWechatAccounts();
  }
}
