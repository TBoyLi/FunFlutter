import 'package:fun_flutter/app/modules/controllers/collect_controller.dart';
import 'package:get/get.dart';

class CollectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CollectController>(
      () => CollectController(),
    );
  }
}
