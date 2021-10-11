import 'package:flutter/material.dart';
import 'package:fun_flutter/app/base/controllers/base_controller.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:get/get.dart';

class StateNormalWidget<T extends BaseController> extends GetView<T> {
  const StateNormalWidget({
    this.onPressed,
    this.height = 180,
    required this.child,
    this.failurePage,
    this.emptyPage,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final Widget? failurePage;
  final Widget? emptyPage;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      builder: (_) {
        if (controller.loadState == LoadState.kLoading) {
          return LoadingBoxPage(
            height: height,
          );
        } else if (controller.loadState == LoadState.kEmpty) {
          return emptyPage ??
              EmptyPage(
                onPressed: onPressed,
              );
        } else if (controller.loadState == LoadState.kFailure) {
          return failurePage ??
              NetWorkErrorPage(
                onPressed: onPressed,
                errorMeg: controller.errorMessage,
              );
        }
        return child;
      },
    );
  }
}
