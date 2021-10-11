import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fun_flutter/app/base/pages/state_refresh_widget.dart';
import 'package:fun_flutter/app/components/items/article_item.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:fun_flutter/app/modules/controllers/answers_controller.dart';
import 'package:get/get.dart';

class AnswersPage extends StatefulWidget {
  const AnswersPage({Key? key}) : super(key: key);

  @override
  _SquareViewState createState() => _SquareViewState();
}

class _SquareViewState extends State<AnswersPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //必须依赖一下controller
    final AnswersController controller = Get.put(AnswersController());
    return GetBuilder(
      init: controller,
      builder: (_) => StateRefreshWidget<AnswersController>(
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
