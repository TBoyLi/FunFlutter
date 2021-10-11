import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:fun_flutter/app/base/pages/state_refresh_widget.dart';
import 'package:fun_flutter/app/components/banner_image.dart';
import 'package:fun_flutter/app/components/items/article_item.dart';
import 'package:fun_flutter/app/modules/controllers/recommend_controller.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  _SquareViewState createState() => _SquareViewState();
}

class _SquareViewState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final RecommendController controller = Get.put(RecommendController());
    return StateRefreshWidget<RecommendController>(
      refreshController: controller.refreshController,
      onLoading: () async {
        controller.onLoad();
      },
      onRefresh: () async {
        controller.initData();
      },
      child: const CustomScrollView(
        slivers: [
          BannerWidget(),
          AirticleListWidget(
            top: true,
          ),
          AirticleListWidget(),
        ],
      ),
    );
  }
}

class BannerWidget extends GetView<RecommendController> {
  const BannerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 160,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Swiper(
          loop: true,
          autoplay: true,
          autoplayDelay: 5000,
          pagination: const SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: DotSwiperPaginationBuilder(size: 8, activeSize: 8),
          ),
          itemCount: controller.banners.length,
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: () {
                // var banner = controller.banners[index];
                // Navigator.of(context).pushNamed(RouteName.articleDetail,
                //     arguments: Article()
                //       ..id = banner.id
                //       ..title = banner.title
                //       ..link = banner.url
                //       ..collect = false);
              },
              child: BannerImage(controller.banners[index]!.imagePath),
            );
          },
        ),
      ),
    );
  }
}

class AirticleListWidget extends GetView<RecommendController> {
  const AirticleListWidget({this.top = false, Key? key}) : super(key: key);
  final bool top;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ArticleItemWidget(
            article:
                top ? controller.topArticles[index] : controller.list[index],
            top: top,
          ),
          childCount:
              top ? controller.topArticles.length : controller.list.length,
        ),
      ),
    );
  }
}
