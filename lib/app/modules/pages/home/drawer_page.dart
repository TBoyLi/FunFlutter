import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fun_flutter/app/components/my_list_title.dart';
import 'package:fun_flutter/app/routes/app_pages.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';

const profileUrl =
    "https://sf3-ttcdn-tos.pstatp.com/img/user-avatar/4639e530a32e1b721605e21908c63b4b~300x300.image";

final usrMenus = [
  {
    'type': 0,
    'leading': Icons.donut_small_rounded,
    'title': 'drawer_my_integral'.tr,
    'trailingTitle': 'drawer_cur_integral'.tr + ':' + '3037',
  },
  {
    'type': 1,
    'leading': Icons.collections_rounded,
    'title': 'drawer_my_collection'.tr,
    'trailingTitle': '',
  },
  {
    'type': 2,
    'leading': Icons.article_rounded,
    'title': 'drawer_my_article'.tr,
    'trailingTitle': '',
  },
  {
    'type': 3,
    'leading': Icons.loop_rounded,
    'title': 'TODO',
    'trailingTitle': '',
  },
];

final usrMenus1 = [
  {
    'type': 4,
    'leading': Icons.language_rounded,
    'title': 'drawer_open_web'.tr,
    'trailingTitle': '',
  },
  {
    'type': 5,
    'leading': Icons.settings_rounded,
    'title': 'drawer_system_settings'.tr,
    'trailingTitle': '',
  },
];

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _primaryColor = Theme.of(context).primaryColor;
    Color _lineColor = Theme.of(context).hintColor.withOpacity(0.1);
    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          color: _primaryColor,
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.LOGIN),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          foregroundImage:
                              CachedNetworkImageProvider(profileUrl),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'tips_login'.tr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'id：-- ' + 'ranking'.tr + ' -- ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Code By RedLi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: usrMenus
              .map(
                (Map<String, dynamic> map) => MyListTitle(
                  leading: map['leading'],
                  title: map['title'],
                  trailingTitle: map['trailingTitle'],
                  type: map['type'],
                  onTap: (int index) {
                    switch (index) {
                      case 0:
                        break;
                      case 1:
                        Get.toNamed(Routes.COLLECT);
                        break;
                      case 2:
                        break;
                      default:
                    }
                  },
                ),
              )
              .toList(),
        ),
        Container(
          height: 5,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          width: double.infinity,
          color: _lineColor,
        ),
        Column(
          children: usrMenus1
              .map(
                (Map<String, dynamic> map) => MyListTitle(
                  leading: map['leading'],
                  title: map['title'],
                  type: map['type'],
                  onTap: (int index) {
                    
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
