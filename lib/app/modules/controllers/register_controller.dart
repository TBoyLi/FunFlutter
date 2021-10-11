import 'package:flutter/material.dart';
import 'package:fun_flutter/app/base/controllers/base_controller.dart';
import 'package:fun_flutter/app/net/api/wan_api.dart';
import 'package:get/get.dart';

class RegisterController extends BaseController {
  final GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> get formKey => _formKey;

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

  String validateUserName(String? value) {
    if ((value ?? '').isEmpty) {
      return 'tips_user_empty'.tr;
    }
    return '';
  }

  String validatePassword(String? value) {
    if ((value ?? '').isEmpty) {
      return 'tips_password_empty'.tr;
    }
    return '';
  }

  //登录
  void login(String name, String password, String rePassword) {
    fetch(
      WanApi.register(name, password, rePassword),
      true,
      success: (value) {},
      failure: (error) {},
    );
  }
}
