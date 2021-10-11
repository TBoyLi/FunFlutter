import 'package:fun_flutter/app/base/controllers/base_refresh_controller.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';

class ArticleListController extends BaseRefeshController {
  int _cid = 294;

  @override
  void onInit() {
    super.onInit();
  }

  void setCidAndFetchData({int cid = 294}) {
    _cid = cid;
    initData();
  }

  @override
  Future<List> loadData({int? pageNum}) async {
    return await WanApi.fetchArticles(pageNum ?? 0, cid: _cid);
  }
}
