import 'package:fun_flutter/app/base/controllers/base_refresh_controller.dart';
import 'package:fun_flutter/app/model/article.dart';
import 'package:fun_flutter/app/model/banner.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';

class RecommendController extends BaseRefeshController {
  List<Banner?>? _banners;
  List<Article?>? _topArticles;

  List<Banner?> get banners => _banners ?? [];

  List<Article?> get topArticles => _topArticles ?? [];

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
    List<Future> futures = [];
    if (pageNum == BaseRefeshController.pageZero) {
      futures.add(WanApi.fetchBanners());
      futures.add(WanApi.fetchTopArticles());
    }
    futures.add(WanApi.fetchArticles(pageNum ?? 0));

    var result = await Future.wait(futures);
    if (pageNum == BaseRefeshController.pageZero) {
      _banners = result[0];
      _topArticles = result[1];
      return result[2];
    } else {
      return result[0];
    }
  }
}
