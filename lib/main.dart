import 'package:FlAuth/objectbox.g.dart';
import 'package:FlAuth/page/home/home_page/view.dart';
import 'package:FlAuth/utils/LifecycleManager.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import 'config/get_pages.dart';
import 'objectBox/objectBox.dart';

var logger = Logger(printer: PrettyPrinter());
late ObjectBox objectbox;
late Admin admin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  if (Admin.isAvailable()) {
    admin = Admin(objectbox.store);
  }
  await GetStorage.init();

  // 初始化生命周期监听
  LifecycleManager().init();
  runApp(const MyApp());
}

class MainController extends GetxController {
  final GetStorage box = GetStorage();
  bool get isDark => box.read('isDarkMode') ?? false;
  ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
  void changeTheme(bool val) => box.write('isDarkMode', val);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    return GetMaterialApp(
      title: 'FlAuth',
      home: HomePage(),
      theme: FlexThemeData.light(),
      darkTheme: FlexThemeData.dark(),
      themeMode: controller.isDark ? ThemeMode.dark : ThemeMode.system,
      initialRoute: '/',
      getPages: GetPages.routes,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    );
  }
}
