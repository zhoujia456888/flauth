
import 'package:FlAuth/page/home/address_page/logic.dart';
import 'package:FlAuth/page/home/password_page/logic.dart';
import 'package:FlAuth/page/home/security_page/logic.dart';
import 'package:FlAuth/page/home/security_page/view.dart';
import 'package:FlAuth/utils/LifecycleManager.dart';
import 'package:FlAuth/utils/authenticateWithBiometricsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../address_page/view.dart';
import '../password_page/view.dart';
import '../settings_page/view.dart';

class HomeLogic extends GetxController {
  final pageList = [SecurityPage(), PasswordPage(), AddressPage(), SettingsPage()];

  final _currentIndex = 0.obs; //
  get currentIndex => _currentIndex.value; //
  set currentIndex(val) => _currentIndex.value = val; //

  //  开启生物识别
  bool openAuthenticateWithBiometrics = Get.find<MainController>().box.read("openAuthenticateWithBiometrics") ?? false;

  bool havePaused = true;

  SecurityLogic securityLogic = Get.find<SecurityLogic>();
  PasswordLogic passwordLogic = Get.find<PasswordLogic>();
  AddressLogic addressLogic = Get.find<AddressLogic>();

  @override
  void onReady() {
    // 注册生命周期监听
    LifecycleManager().addListener(handleLifecycleEvent);
    if (openAuthenticateWithBiometrics && havePaused) {
      awaitOpenAuthenticateWithBiometrics();
    }

    super.onReady();
  }

  @override
  void onClose() {
    LifecycleManager().removeListener(handleLifecycleEvent);
    super.onClose();
  }

  void handleLifecycleEvent(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // 应用进入后台，记录当前状态//清空所有页面数据
      havePaused = true;
      if (openAuthenticateWithBiometrics) {
        hideData();
      }
    }
    if (state == AppLifecycleState.resumed) {
      // 应用回到前台，判断是否开启生物识别
      if (openAuthenticateWithBiometrics && havePaused) {
        awaitOpenAuthenticateWithBiometrics();
      }
    }
  }

  //开启生物识别
  void awaitOpenAuthenticateWithBiometrics() async {
    AuthenticateWithBiometricsUtils.authenticateWithBiometrics().then((value) async {
      if (value) {
        havePaused = false;
        // 告诉页面加载数据，比如调用 refresh 方法
        showData();
      } else {
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    });
  }

  //显示数据
  void showData() {
    securityLogic.getCodeByDb(); // 刷新安全码列表
    passwordLogic.getPassWordByDb(); //  刷新密码列表
    addressLogic.getAddressByDb(); //  刷新地址列表
  }

  void hideData() {
    securityLogic.hideCodeListView();
    passwordLogic.passwordModelList.clear();
    addressLogic.addressModelList.clear();
  }
}
