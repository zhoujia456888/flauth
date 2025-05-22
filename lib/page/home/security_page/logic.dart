import 'dart:async';
import 'dart:io';

import 'package:auth_totp/auth_totp.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../assets.dart';
import '../../../config/get_pages.dart';
import '../../../main.dart';
import '../../../model/totp_model/totp_model.dart';
import '../../../utils/TotpUrlUtils.dart';

class SecurityLogic extends GetxController with GetTickerProviderStateMixin {
  //安全码列表
  final codeList = <TotpModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    refreshCode();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //  生成TOTP
  generateTOTPCode(String secretKey) {
    String generatedTOTPCode = AuthTOTP.generateTOTPCode(secretKey: secretKey, interval: 30);
    return generatedTOTPCode;
  }

  //  刷新TOTP码
  refreshCode() {
    if (codeList.isNotEmpty) {
      for (int i = 0; i < codeList.length; i++) {
        final totpModel = codeList[i];
        startCountdown(i, totpModel);
      }
    }
  }

  //  开始倒计时
  startCountdown(int index, TotpModel totpModel) {
    String newCode = generateTOTPCode(totpModel.secret!);

    AnimationController controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: (totpModel.initialTime ?? 30).toInt()), // 动画持续时间
    );

    // 先声明 animation 变量
    late Animation<double> animation;
    // 使用 Tween 创建从 1.0 到 0.0 的动画
    animation = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        codeList[index] = totpModel.copyWith(countdownTime: animation.value, code: newCode);

        // 监听动画变化并更新 UI
        if (animation.value <= 0.0) {
          newCode = generateTOTPCode(totpModel.secret!);
          codeList[index] = totpModel.copyWith(code: newCode);
          controller.reset();
          controller.forward();
        }
      });
    controller.forward();
  }

  //  扫码
  scanCode() async {
    var data = await Get.toNamed(GetPages.scanCodePage);
    if (data != null) {
      logger.e("dddddddddddddddddddddd+$data");
    }
  }

  //文件选择
  filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      final contents = await file.readAsString();
      logger.e(contents);
      var totpMapList = TotpUrlUtils.splitTotp(contents);
      for (var totpMap in totpMapList) {
        codeList.add(TotpModel.fromJson(totpMap));
      }
      refreshCode();
    } else {
      // User canceled the picker
    }
  }
}
