import 'package:flutter/material.dart';
import 'package:fun_flutter/app/base/controllers/base_controller.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';
import 'package:fun_flutter/app/utils/storage_manager.dart';
import 'package:fun_flutter/global.dart';

class LoginController extends BaseController {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get userController => _userController;
  TextEditingController get pwdController => _pwdController;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  //登录
  void login(String username, String password, {required Function succes}) {
    fetch(
      WanApi.login(username, password),
      true,
      success: (user) {
        //保存用户信息
        StorageManager.localStorage.setItem(Global.kUser, user);
        succes();
      },
      failure: (error) => showError(error),
    );
  }
}
