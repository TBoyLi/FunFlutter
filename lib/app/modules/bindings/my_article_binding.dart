import 'package:fun_flutter/app/modules/controllers/my_article_controller.dart';
import 'package:get/get.dart';

class MyArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyArticleController>(
      () => MyArticleController(),
    );
  }
}
