import 'package:fun_flutter/app/base/controllers/base_list_controller.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';

class ProjectCategoryController extends BaseListController {
  @override
  Future<void> onInit() async {
    super.onInit();
    initData();
  }

  @override
  Future<List> loadData({int? pageNum}) async {
    return await WanApi.fetchProjectCategories();
  }
}
