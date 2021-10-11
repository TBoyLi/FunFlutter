import 'package:fun_flutter/app/base/controllers/base_controller.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:fun_flutter/app/model/tree.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';

class StruController extends BaseController {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<Tree> _parent = [];
  List<Tree> get parent => _parent;

  List<Tree> _children = [];
  List<Tree> get children => _children;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void setChildren(List<Tree> children) {
    _children = children;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    loadState = LoadState.kLoading;
    _parent = await WanApi.fetchTreeCategories();
    _children = _parent[0].children;
    loadState = LoadState.kDone;
    update();
  }
}
