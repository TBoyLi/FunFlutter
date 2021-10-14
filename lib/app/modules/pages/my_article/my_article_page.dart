import 'package:flutter/material.dart';
import 'package:fun_flutter/app/modules/controllers/my_article_controller.dart';
import 'package:get/get.dart';

class MyArticlePage extends GetView<MyArticleController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('MyArticlePage')),

    body: SafeArea(
      child: Text('MyArticleController'))
    );
  }
}