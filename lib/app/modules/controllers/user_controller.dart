import 'package:fun_flutter/app/model/user.dart';
import 'package:fun_flutter/app/utils/storage_manager.dart';
import 'package:fun_flutter/global.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final hasUser = false.obs;

  void saveLocalUser(User user) {
    StorageManager.localStorage.setItem(Global.kUser, user);
    hasUser.value = true;
  }

  void clearLocalUser() {
    StorageManager.localStorage.clear();
    hasUser.value = false;
  }

  User getLocalUser() {
    return StorageManager.localStorage.getItem(Global.kUser);
  }
}
