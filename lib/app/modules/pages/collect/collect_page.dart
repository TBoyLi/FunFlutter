import 'package:flutter/material.dart';
import 'package:fun_flutter/app/base/pages/state_list_widget.dart';
import 'package:fun_flutter/app/base/pages/state_refresh_widget.dart';
import 'package:fun_flutter/app/components/items/article_item.dart';
import 'package:fun_flutter/app/model/site.dart';
import 'package:fun_flutter/app/modules/controllers/article_collect_controller.dart';
import 'package:fun_flutter/app/modules/controllers/site_collect_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

final titles = ['article'.tr, 'site'.tr];

class CollectPage extends StatelessWidget {
  const CollectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: titles.length,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: List.generate(
              titles.length,
              (index) => Tab(
                text: titles[index],
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: const TabBarView(
          children: [
            ArticleCollectPage(),
            SiteCollectPage(),
          ],
        ),
      ),
    );
  }
}

class ArticleCollectPage extends StatefulWidget {
  const ArticleCollectPage({Key? key}) : super(key: key);

  @override
  _ArticleCollectPageState createState() => _ArticleCollectPageState();
}

class _ArticleCollectPageState extends State<ArticleCollectPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ArticleCollectController controller =
        Get.put(ArticleCollectController());
    return GetBuilder<ArticleCollectController>(
      init: controller,
      builder: (_) => StateRefreshWidget<ArticleCollectController>(
        refreshController: controller.refreshController,
        onPressed: () => controller.initData(),
        onRefresh: () async {
          controller.initData();
        },
        onLoading: () async {
          controller.onLoad();
        },
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.list.length,
          itemBuilder: (context, index) => ArticleItemWidget(
            article: controller.list[index],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SiteCollectPage extends StatefulWidget {
  const SiteCollectPage({Key? key}) : super(key: key);

  @override
  _SiteCollectPageState createState() => _SiteCollectPageState();
}

class _SiteCollectPageState extends State<SiteCollectPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final SiteCollectController controller = Get.put(SiteCollectController());
    return GetBuilder<SiteCollectController>(
      init: controller,
      builder: (_) => StateListWidget<SiteCollectController>(
        onPressed: () => controller.initData(),
        child: ListView.separated(
          itemCount: controller.list.length,
          itemBuilder: (context, index) {
            final Site site = controller.list[index];
            return ListTile(
              title: Text(site.name ?? ''),
              subtitle: Text(site.link ?? ''),
            );
          },
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              thickness: 1,
              height: 0.5,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
