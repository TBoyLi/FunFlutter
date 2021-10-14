import 'package:flutter/material.dart';
import 'package:fun_flutter/app/base/controllers/base_controller.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:get/get.dart';

class StateListWidget<T extends BaseController> extends GetView<T> {
  const StateListWidget({
    this.onPressed,
    required this.child,
    this.failurePage,
    this.emptyPage,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final Widget? failurePage;
  final Widget? emptyPage;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      // init: controller,
      builder: (_) {
        if (controller.loadState == LoadState.kLoading) {
          return const LoadingListPage();
        } else if (controller.loadState == LoadState.kEmpty) {
          return emptyPage ??
              EmptyPage(
                onPressed: onPressed,
              );
        } else if (controller.loadState == LoadState.kLogin) {
          return LoginErrorPage(
            // onPressed: onPressed,
            errorMeg: controller.errorMessage,
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
