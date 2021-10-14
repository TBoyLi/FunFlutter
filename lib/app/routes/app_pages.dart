import 'package:fun_flutter/app/modules/bindings/collect_binding.dart';
import 'package:fun_flutter/app/modules/bindings/project_binding.dart';
import 'package:fun_flutter/app/modules/bindings/project_list_binding.dart';
import 'package:fun_flutter/app/modules/controllers/my_article_controller.dart';
import 'package:fun_flutter/app/modules/pages/article/article_category_tab_page.dart';
import 'package:fun_flutter/app/modules/pages/article/article_detail_page.dart';
import 'package:fun_flutter/app/modules/pages/collect/collect_page.dart';
import 'package:fun_flutter/app/modules/pages/article/article_list_page.dart';
import 'package:fun_flutter/app/modules/pages/my_article/my_article_page.dart';
import 'package:fun_flutter/app/modules/pages/project/project_page.dart';
import 'package:get/get.dart';

import 'package:fun_flutter/app/modules/bindings/answers_binding.dart';
import 'package:fun_flutter/app/modules/pages/home/answers_page.dart';
import 'package:fun_flutter/app/modules/pages/home/home_page.dart';
import 'package:fun_flutter/app/modules/bindings/recommend_binding.dart';
import 'package:fun_flutter/app/modules/pages/home/recommend_page.dart';
import 'package:fun_flutter/app/modules/bindings/square_binding.dart';
import 'package:fun_flutter/app/modules/pages/home/square_page.dart';
import 'package:fun_flutter/app/modules/bindings/index_binding.dart';
import 'package:fun_flutter/app/modules/pages/index/index_page.dart';
import 'package:fun_flutter/app/modules/bindings/login_binding.dart';
import 'package:fun_flutter/app/modules/pages/login/login_page.dart';
import 'package:fun_flutter/app/modules/pages/verity/verity_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.INDEX;

  static final routes = [
    GetPage(
      name: _Paths.INDEX,
      page: () => const IndexPage(),
      binding: IndexBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      children: [
        GetPage(
          name: _Paths.VERITY,
          page: () => const VerityPage(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.COLLECT,
      page: () => const CollectPage(),
      // binding: CollectBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE_CATEGORY_TAB,
      page: () => const ArticleCategoryTabPage(),
    ),
    GetPage(
      name: _Paths.ARTICLE_DETAIL,
      page: () => const ArticleDetailPage(),
    ),
    GetPage(
      name: _Paths.MY_ARTICLE,
      page: () => MyArticlePage(),
    ),
  ];
}
