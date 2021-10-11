import 'package:fun_flutter/app/base/controllers/base_controller.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:fun_flutter/app/model/article.dart';
import 'package:fun_flutter/app/model/navigation_site.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';

class NavigationController extends BaseController {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<NavigationSite> _parent = [];
  List<NavigationSite> get parent => _parent;

  List<Article> _children = [];
  List<Article> get children => _children;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void setChildren(List<Article> children) {
    _children = children;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    loadState = LoadState.kLoading;
    _parent = await WanApi.fetchNavigationSite();
    _children = _parent[0].articles;
    loadState = LoadState.kDone;
    update();
  }
}
