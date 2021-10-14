// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fun_flutter/app/components/skeleton.dart';
import 'package:fun_flutter/app/components/skeleton_item.dart';
import 'package:fun_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

enum LoadState { kLoading, kSuccess, kFailure, kDone, kLogin, kEmpty }

class EmptyPage extends StatelessWidget {
  VoidCallback? onPressed;

  EmptyPage({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/no_data.png",
              width: 50,
              height: 50,
              color: Theme.of(context).primaryColor.withOpacity(0.8),
            ),
            Text(
              "status_no_data".tr,
              style: const TextStyle(color: Colors.black),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            OutlinedButton(
              child: Text(
                "status_refresh".tr,
                style: const TextStyle(color: Colors.blue, fontSize: 15),
              ),
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}

class LoadingBoxPage extends StatelessWidget {
  const LoadingBoxPage({
    Key? key,
    this.width = double.infinity,
    this.height = 180,
    this.isCircle = false,
  }) : super(key: key);

  final double width;
  final double height;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: width,
      height: height,
      isCircle: isCircle,
    );
  }
}

///加载数据之前给用户一个正在加载都状态提示
class LoadingListPage extends StatelessWidget {
  const LoadingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonList(
      builder: (context, index) => const SkeletonItem(),
    );
  }
}

class CircularProgressIndicatorPage extends StatelessWidget {
  const CircularProgressIndicatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}

class NetWorkErrorPage extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? errorMeg;

  const NetWorkErrorPage({Key? key, this.errorMeg, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off,
                size: 50, color: Theme.of(context).primaryColor),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text(errorMeg ?? "status_no_net".tr,
                style: Theme.of(context).textTheme.subtitle1),
            const Padding(padding: EdgeInsets.only(top: 10)),
            OutlinedButton(
              child: Text("status_refresh".tr,
                  style: const TextStyle(color: Colors.blue, fontSize: 15)),
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}

class LoginErrorPage extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? errorMeg;

  const LoginErrorPage({Key? key, this.errorMeg, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_outlined,
                size: 50, color: Theme.of(context).primaryColor),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text(errorMeg ?? "tips_login".tr,
                style: Theme.of(context).textTheme.subtitle1),
            const Padding(padding: EdgeInsets.only(top: 10)),
            OutlinedButton(
              child: Text("login".tr,
                  style: const TextStyle(color: Colors.blue, fontSize: 15)),
              onPressed: () => Get.toNamed(Routes.LOGIN),
            )
          ],
        ),
      ),
    );
  }
}
