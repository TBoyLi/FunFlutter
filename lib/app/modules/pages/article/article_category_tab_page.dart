import 'package:flutter/material.dart';
import 'package:fun_flutter/app/model/tree.dart';
import 'package:get/get.dart';

import 'article_list_page.dart';

class ArticleCategoryTabPage extends StatelessWidget {
  const ArticleCategoryTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Tree tree = Get.arguments['tree'];
    final int index = Get.arguments['index'];
    return DefaultTabController(
      length: tree.children.length,
      initialIndex: index,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(tree.name),
            bottom: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: List.generate(
                tree.children.length,
                (index) => Tab(
                  text: tree.children[index].name,
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: List.generate(
              tree.children.length,
              (index) => ArticleListPage(
                cid: tree.children[index].id,
              ),
            ),
          )),
    );
  }
}
