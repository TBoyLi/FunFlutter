import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:fun_flutter/generated/locales.g.dart';

import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'app/net/http/http_manager.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/storage_manager.dart';

Future<void> main() async {
  Logger.init(!kReleaseMode);

  //告诉程序进入主程序之前需要做一些操作
  WidgetsFlutterBinding.ensureInitialized();

  //初始化持久工具
  await StorageManager.init();
  //初始化cookiejar
  await HttpManager.initCookieJar();

  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Fun Flutter",
        translationsKeys: AppTranslation.translations,
        locale: const Locale('zh', 'CN'),
        // locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
      position: ToastPosition.bottom,
    );
  }
}
