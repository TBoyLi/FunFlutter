import 'package:flutter/material.dart';
import 'package:fun_flutter/app/base/pages/state_refresh_widget.dart';
import 'package:fun_flutter/app/modules/controllers/collect_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CollectPage extends GetView<CollectController> {
  const CollectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收藏'),
        centerTitle: true,
      ),
      body: StateRefreshWidget<CollectController>(
        refreshController: controller.refreshController,
        onPressed: () => controller.initData(),
        child: Text('${controller.list.length}'),
      ),
    );
  }
}
