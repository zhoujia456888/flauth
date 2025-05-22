import 'package:FlAuth/page/home/security_page/view.dart';
import 'package:get/get.dart';

import '../address_page/view.dart';
import '../password_page/view.dart';
import '../settings_page/view.dart';

class HomeLogic extends GetxController {


  final pageList = [SecurityPage(),  PasswordPage(), AddressPage(), SettingsPage()];

  final _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;
  set currentIndex(val) => _currentIndex.value = val;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
