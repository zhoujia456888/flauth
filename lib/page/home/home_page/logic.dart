import 'dart:io';

import 'package:FlAuth/page/home/security_page/view.dart';
import 'package:FlAuth/utils/authenticateWithBiometricsUtils.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../main.dart';
import '../address_page/view.dart';
import '../password_page/view.dart';
import '../settings_page/view.dart';

class HomeLogic extends  GetxController {
  final pageList = [SecurityPage(), PasswordPage(), AddressPage(), SettingsPage()];

  final _currentIndex = 0.obs; //
  get currentIndex => _currentIndex.value; //
  set currentIndex(val) => _currentIndex.value = val; //

  //  开启生物识别
  bool openAuthenticateWithBiometrics = spUtil.getBool("openAuthenticateWithBiometrics") ?? false;


  @override
  void onReady() {
    if (openAuthenticateWithBiometrics) {
      awaitOpenAuthenticateWithBiometrics();
    }
    super.onReady();
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //开启生物识别
  void awaitOpenAuthenticateWithBiometrics() async {
    AuthenticateWithBiometricsUtils.authenticateWithBiometrics().then((value) async {
      if (value) {
        logger.e("验证成功");
      } else {
        logger.e("验证失败");
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    });
  }
}
