import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TabIconData {
  TabIconData({
    this.name = 'name',
    this.imagePath = Icons.error,
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  IconData imagePath;
  bool isSelected;
  int index;
  String name;

  /// icon 动画
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      name: 'tab_home'.tr,
      imagePath: Icons.account_balance_outlined,
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      name: 'tab_project'.tr,
      imagePath: Icons.widgets_outlined,
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      name: 'tab_wechat'.tr,
      imagePath: Icons.pages_outlined,
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      name: 'tab_structure'.tr,
      imagePath: Icons.low_priority_outlined,
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
