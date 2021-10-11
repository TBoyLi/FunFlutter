
import 'package:flutter/material.dart';
import 'package:fun_flutter/app/base/pages/state_refresh_widget.dart';
import 'package:fun_flutter/app/components/items/article_item.dart';
import 'package:fun_flutter/app/modules/controllers/wechat_list_controller.dart';
import 'package:get/get.dart';

class WechatListPage extends StatefulWidget {
  const WechatListPage({Key? key, this.cid = 408}) : super(key: key);

  final int cid;

  @override
  _WechatListPageState createState() => _WechatListPageState();
}

class _WechatListPageState extends State<WechatListPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final WechatListController controller = Get.put(WechatListController());
    return GetBuilder(
      init: controller,
      initState: (_) => controller.setCidAndFetchData(cid: widget.cid),
      builder: (_) => StateRefreshWidget<WechatListController>(
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