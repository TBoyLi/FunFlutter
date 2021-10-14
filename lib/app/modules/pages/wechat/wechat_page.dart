import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:fun_flutter/app/modules/controllers/wechat_controller.dart';
import 'package:fun_flutter/app/modules/pages/wechat/wechat_list_page.dart';
import 'package:get/get.dart';

class WeChatPage extends StatefulWidget {
  const WeChatPage({Key? key}) : super(key: key);

  @override
  _WeChatPageState createState() => _WeChatPageState();
}

class _WeChatPageState extends State<WeChatPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final WechatController controller = Get.put(WechatController());
    return GetBuilder(
      init: controller,
      builder: (_) => DefaultTabController(
        length: controller.list.length,
        child: Scaffold(
          appBar: AppBar(
            title: Stack(
              children: [
                const CategoryDropdownWidget(),
                Container(
                  margin: const EdgeInsets.only(right: 25),
                  color: Theme.of(context).primaryColor.withOpacity(1),
                  child: TabBar(
                    isScrollable: true,
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 15),
                    tabs: List.generate(
                      controller.list.length,
                      (index) => Tab(
                        text: controller.list[index]?.name,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
              children: List.generate(
                controller.list.length,
                (index) => WechatListPage(
                  cid: controller.list[index]?.id ?? 294,
                ),
              ),
            ),
        ),
      ),
    );
  }
}

class CategoryDropdownWidget extends GetView<WechatController> {
  const CategoryDropdownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WechatController controller = Get.put(WechatController());
    return Align(
      alignment: const Alignment(1, 1),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
        ),
        child: GetBuilder(
          init: controller,
          builder: (_) => DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              elevation: 0,
              // value: 0,
              style: Theme.of(context).primaryTextTheme.subtitle2,
              items: List.generate(controller.list.length, (index) {
                return DropdownMenuItem(
                  value: index,
                  child: Text(
                    controller.list[index]?.name ?? '',
                  ),
                );
              }),
              onChanged: (value) {
                DefaultTabController.of(context)?.animateTo(value ?? 0);
              },
              isExpanded: true,
              icon: controller.loadState == LoadState.kLoading
                  ? const Padding(
                      padding: EdgeInsets.only(top: 15, right: 5),
                      child: SpinKitCircle(
                        color: Colors.white,
                        size: 20.0,
                      ),
                    )
                  : const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
