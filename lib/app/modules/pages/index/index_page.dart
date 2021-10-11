import 'package:flutter/material.dart';
import 'package:fun_flutter/app/components/navigation_bottom/navigation_bottom_bar.dart';
import 'package:fun_flutter/app/components/navigation_bottom/tab_icon_data.dart';
import 'package:fun_flutter/app/modules/pages/home/home_page.dart';
import 'package:fun_flutter/app/modules/pages/project/project_page.dart';
import 'package:fun_flutter/app/modules/pages/structure/structure_page.dart';
import 'package:fun_flutter/app/modules/pages/wechat/wechat_page.dart';

import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../../controllers/index_controller.dart';

final List<Widget> _pages = [
  const HomePage(),
  const ProjectPage(),
  const WeChatPage(),
  const StructurePage()
];

final PageController _pageController = PageController();

class IndexPage extends GetView<IndexController> {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime lastDateTime = DateTime.now();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          if (DateTime.now().difference(lastDateTime) >
              const Duration(seconds: 1)) {
            lastDateTime = DateTime.now();
            showToast("再次点击退出程序",
                backgroundColor: Theme.of(context).primaryColor);
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Column(
          children: [
            content(),
            bottomBar(),
          ],
        ),
      ),
    );
  }

  Widget content() {
    return Expanded(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pages,
      ),
    );
  }

  Widget bottomBar() {
    return NavigationBottomBar(
        tabIconsList: TabIconData.tabIconsList,
        changeIndex: (index) => _pageController.jumpToPage(index),
        addClick: () {
          debugPrint('点击了中间的按钮');
        },
      );
  }
}
