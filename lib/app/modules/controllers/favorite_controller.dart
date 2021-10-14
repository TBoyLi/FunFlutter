import 'package:fun_flutter/app/base/controllers/base_controller.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';

class FavoriteController extends BaseController {
  bool isCollect = false;

  void refreshCollect(bool collect, int id) {
    isCollect = collect;
    update([id]);
  }

  Future<void> collect(bool collect, int id) async {
    if (collect) {
      fetch(
        WanApi.unCollect(id),
        true,
        success: (value) {
          refreshCollect(false, id);
        },
        refreshItem: true,
        id: id,
      );
    } else {
      fetch(
        WanApi.collect(id),
        true,
        success: (value) {
          refreshCollect(true, id);
        },
        refreshItem: true,
        id: id,
      );
    }
  }
}
