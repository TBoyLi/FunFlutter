import 'package:fun_flutter/app/base/controllers/base_refresh_controller.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';

class CollectController extends BaseRefeshController {
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  Future<List> loadData({int? pageNum}) async {
    return await WanApi.fetchCollectList(pageNum ?? 0);
  }
}
