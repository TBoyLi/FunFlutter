import 'package:flutter/material.dart';
import 'package:fun_flutter/app/components/verify/safe_verify.dart';

import 'package:get/get.dart';

class VerityPage extends GetView {
  const VerityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('安全验证'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('为了你的账号安全，本次登录需要进行验证'),
              const Text('请将下方的图标移动到圆形区域内'),
              const SizedBox(height: 20),
              Expanded(
                child: SafeVerity(lister: (state) {
                  if (state) {
                    Get.back(result: state);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
