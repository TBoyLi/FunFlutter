import 'package:flutter/material.dart';
import 'package:fun_flutter/app/base/pages/state_refresh_widget.dart';
import 'package:fun_flutter/app/components/items/article_item.dart';
import 'package:fun_flutter/app/modules/controllers/square_controller.dart';

import 'package:get/get.dart';

class SquarePage extends StatefulWidget {
  const SquarePage({Key? key}) : super(key: key);

  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final SquareController controller = Get.put(SquareController());
    return GetBuilder(
      init: controller,
      builder: (_) => StateRefreshWidget<SquareController>(
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