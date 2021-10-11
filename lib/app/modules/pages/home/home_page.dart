import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fun_flutter/app/modules/pages/home/answers_page.dart';
import 'package:fun_flutter/app/modules/pages/home/drawer_page.dart';
import 'package:fun_flutter/app/modules/pages/home/recommend_page.dart';
import 'package:fun_flutter/app/modules/pages/home/square_page.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

final tabs = ['home_square'.tr, 'home_recommend'.tr, 'home_answers'.tr];

final views = [const SquarePage(), const RecommendPage(), const AnswersPage()];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: 1, length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          // leading: const Icon(Icons.person_outline),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_outlined),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
          centerTitle: true,
          title: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: tabs
                .map(
                  (title) => Tab(
                    text: title,
                  ),
                )
                .toList(),
          ),
        ),
        drawer: const Drawer(
          elevation: 3,
          child: DrawerPage(),
        ),
        body: TabBarView(
          children: views,
          controller: _tabController,
        ),
      ),
    );
  }
}
