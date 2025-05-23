import 'package:FlAuth/objectbox.g.dart';
import 'package:FlAuth/page/home/home_page/view.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';

import 'config/get_pages.dart';
import 'objectBox/objectBox.dart';

var logger = Logger(printer: PrettyPrinter());
late ObjectBox objectbox;
late Admin admin;
late Store store;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();
  store = await openStore();
  if (Admin.isAvailable()) {
    admin = Admin(store);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FlAuth',
      home: HomePage(),
      theme: FlexThemeData.light(),
      darkTheme: FlexThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      getPages: GetPages.routes,
      navigatorObservers: [FlutterSmartDialog.observer],
      // here
      builder: FlutterSmartDialog.init(),
    );
  }
}
