import 'package:flutter/material.dart';
import 'package:fun_flutter/app/base/pages/state_refresh_widget.dart';
import 'package:fun_flutter/app/components/items/article_item.dart';
import 'package:fun_flutter/app/modules/controllers/article_list_controller.dart';
import 'package:get/get.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({Key? key, this.cid = 294}) : super(key: key);

  final int cid;

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ArticleListController controller = Get.put(ArticleListController());
    return GetBuilder(
      init: controller,
      initState: (_) => controller.setCidAndFetchData(cid: widget.cid),
      builder: (_) => StateRefreshWidget<ArticleListController>(
        refreshController: controller.refreshController,
        onRefresh: () async {
          controller.initData();
        },
        onLoading: () async {
          controller.onLoad();
        },
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ArticleItemWidget(
                  article: controller.list[index],
                  top: false,
                ),
                childCount: controller.list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
