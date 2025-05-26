import 'package:FlAuth/main.dart';
import 'package:FlAuth/utils/authenticateWithBiometricsUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class SettingsLogic extends GetxController {
  final _isDarkMode = false.obs; //黑暗模式
  get isDarkMode => _isDarkMode.value; //
  set isDarkMode(val) => _isDarkMode.value = val; //

  final _isAutoHideCode = false.obs; //是否自动隐藏密码
  get isAutoHideCode => _isAutoHideCode.value; //
  set isAutoHideCode(val) => _isAutoHideCode.value = val; //

  final _openAuthenticateWithBiometrics = false.obs; //
  get openAuthenticateWithBiometrics => _openAuthenticateWithBiometrics.value; //
  set openAuthenticateWithBiometrics(val) => _openAuthenticateWithBiometrics.value = val; //

  late final bool canAuthenticateWithBiometrics; //是否支持生物识别

  final _canAuthenticate = false.obs;//是否支持生物识别
  get canAuthenticate => _canAuthenticate.value;
  set canAuthenticate(val) => _canAuthenticate.value = val;


  @override
  void onInit() async {
    isDarkMode = spUtil.getBool("isDarkMode") ?? false;
    isAutoHideCode = spUtil.getBool("isAutoHideCode") ?? false;
    openAuthenticateWithBiometrics = spUtil.getBool("openAuthenticateWithBiometrics")??false;

    final LocalAuthentication auth = LocalAuthentication();
    canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    canAuthenticate = await auth.isDeviceSupported();
    logger.e("canAuthenticateWith:$canAuthenticate");
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //  自动隐藏
  void awaitHideCode(bool isShow) {
    spUtil.setBool("isAutoHideCode", isShow);
    isAutoHideCode = isShow;
  }

  //开启生物识别
  void awaitOpenAuthenticateWithBiometrics(bool isOpen) async {
    AuthenticateWithBiometricsUtils.authenticateWithBiometrics().then((value) {
      if (value) {
        logger.e("验证成功");
        spUtil.setBool("openAuthenticateWithBiometrics", isOpen);
        openAuthenticateWithBiometrics = isOpen;
      } else {
        logger.e("验证失败");
      }
    });
  }

  //  切换深色模式
  void changeDarkMode(bool value) {
    spUtil.setBool("isDarkMode", value);
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    isDarkMode = value;
  }
}
