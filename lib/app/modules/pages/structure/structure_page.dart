import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:fun_flutter/app/modules/controllers/navigation_controller.dart';
import 'package:fun_flutter/app/modules/controllers/stru_controller.dart';
import 'package:fun_flutter/app/routes/app_pages.dart';
import 'package:fun_flutter/app/utils/color_utils.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

final menus = ['structure_stru'.tr, 'structure_navigation'.tr];

class StructurePage extends StatefulWidget {
  const StructurePage({Key? key}) : super(key: key);

  @override
  _StructurePageState createState() => _StructurePageState();
}

class _StructurePageState extends State<StructurePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: menus.length,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: List.generate(
              menus.length,
              (index) => Tab(
                text: menus[index],
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: const TabBarView(
          children: [StruPage(), NavigationPage()],
        ),
      ),
    );
  }
}

class StruPage extends StatefulWidget {
  const StruPage({Key? key}) : super(key: key);

  @override
  _StruPageState createState() => _StruPageState();
}

class _StruPageState extends State<StruPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final StruController controller = Get.put(StruController());
    final Color themeColor = Theme.of(context).primaryColor;
    return GetBuilder(
      init: controller,
      builder: (_) {
        if (controller.loadState == LoadState.kLoading) {
          return SpinKitFadingCircle(color: themeColor);
        }
        return Row(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.setSelectedIndex(index);
                      controller.setChildren(controller.parent[index].children);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          height: 40,
                          child: Text(
                            controller.parent[index].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              color: (index == controller.selectedIndex)
                                  ? themeColor
                                  : Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .color,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 10,
                          child: Visibility(
                            visible: controller.selectedIndex == index,
                            child: Container(
                              height: 20,
                              width: 6,
                              color: themeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    indent: 12,
                    height: 1,
                  );
                },
                itemCount: controller.parent.length,
              ),
            ),
            Container(
              height: double.infinity,
              width: 0.5,
              color: Colors.black12,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GridView.custom(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3.5,
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return MaterialButton(
                        color: ColorUtils.getRandomColor(),
                        textColor: Colors.white,
                        onPressed: () {
                          Get.toNamed(
                            Routes.ARTICLE_CATEGORY_TAB,
                            arguments: {
                              'index': index,
                              'tree':
                                  controller.parent[controller.selectedIndex],
                            },
                          );
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          controller.children[index].name,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    childCount: controller.children.length,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());
    final Color themeColor = Theme.of(context).primaryColor;
    return GetBuilder(
      init: controller,
      builder: (_) {
        if (controller.loadState == LoadState.kLoading) {
          return SpinKitFadingCircle(color: themeColor);
        }
        return Row(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.setSelectedIndex(index);
                      controller.setChildren(controller.parent[index].articles);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          height: 40,
                          child: Text(
                            controller.parent[index].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              color: (index == controller.selectedIndex)
                                  ? themeColor
                                  : Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .color,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 10,
                          child: Visibility(
                            visible: controller.selectedIndex == index,
                            child: Container(
                              height: 20,
                              width: 6,
                              color: themeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    indent: 12,
                    height: 1,
                  );
                },
                itemCount: controller.parent.length,
              ),
            ),
            Container(
              height: double.infinity,
              width: 0.5,
              color: Colors.black12,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GridView.custom(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3.5,
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return MaterialButton(
                        color: ColorUtils.getRandomColor(),
                        textColor: Colors.white,
                        onPressed: () {
                          Get.toNamed(
                            Routes.ARTICLE_DETAIL,
                            arguments: {
                              'article': controller.children[index],
                            },
                          );
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          controller.children[index].title ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    childCount: controller.children.length,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
