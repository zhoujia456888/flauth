import 'package:get/get_navigation/src/routes/get_route.dart';

import '../page/home/address_page/view.dart';
import '../page/home/home_page/view.dart';
import '../page/home/password_page/view.dart';
import '../page/home/security_page/view.dart';
import '../page/home/settings_page/view.dart';
import '../page/scan_code_page/view.dart';

class GetPages {

  static const String homePage = "/homePage";
  static const String securityPage = "/securityPage";
  static const String passwordPage = "/passwordPage";
  static const String addressPage = "/addressPage";
  static const String settingsPage = "/settingsPage";
  static const String scanCodePage = "/scanCodePage";

  static final List<GetPage> routes = [
    GetPage(name: homePage, page: () => HomePage()),
    GetPage(name: securityPage, page: () => SecurityPage()),
    GetPage(name: passwordPage, page: () => PasswordPage()),
    GetPage(name: addressPage, page: () => AddressPage()),
    GetPage(name: settingsPage, page: () => SettingsPage()),
    GetPage(name: scanCodePage, page: () => ScanCodePage()),
  ];
}
