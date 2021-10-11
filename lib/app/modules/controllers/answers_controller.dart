import 'package:fun_flutter/app/base/controllers/base_refresh_controller.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';

class AnswersController extends BaseRefeshController {
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  @override
  Future<List> loadData({int? pageNum}) async {
    return await WanApi.fetchQuestions(pageNum ?? 0);
  }
}
