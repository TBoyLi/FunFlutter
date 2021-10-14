import 'package:fun_flutter/app/modules/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../controllers/index_controller.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndexController>(
      () => IndexController(),
    );
    //根路径引入UserController
    Get.lazyPut<UserController>(
      () => UserController(),
      fenix: true,
    );
  }
}
