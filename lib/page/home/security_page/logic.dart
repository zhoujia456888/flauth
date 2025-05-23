import 'dart:io';

import 'package:FlAuth/objectBox/totpModelBoxUtils.dart';
import 'package:FlAuth/utils/TotpIconUtils.dart';
import 'package:auth_totp/auth_totp.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:steam_totp/steam_totp.dart';

import '../../../config/get_pages.dart';
import '../../../main.dart';
import '../../../model/totp_model/totp_model.dart';
import '../../../utils/TotpUrlUtils.dart';

class SecurityLogic extends GetxController with GetTickerProviderStateMixin {
  //安全码列表
  RxList<Rx<TotpModel>> codeList = <Rx<TotpModel>>[].obs;

  @override
  void onReady() {
    getCodeByDb();
    super.onReady();
  }

  //  生成TOTP
  generateTOTPCode(String issuer, String secretKey) {
    String generatedTOTPCode = "";
    if (issuer.contains("steam")) {
      generatedTOTPCode = SteamTOTP(secret: secretKey).generate();
    } else {
      generatedTOTPCode = AuthTOTP.generateTOTPCode(secretKey: secretKey, interval: 30);
    }

    return generatedTOTPCode;
  }

  //  从数据库获取TOTP码
  getCodeByDb() async {
    List<TotpModel> totpMapList = TotpModelBoxUtils().getAllTotp();
    for (var totpModel in totpMapList) {
      Rx<TotpModel> totpModelObs = totpModel.obs;
      codeList.add(totpModelObs);
    }
    refreshCode();
  }

  //  刷新TOTP码
  refreshCode() {
    if (codeList.isNotEmpty) {
      for (int i = 0; i < codeList.length; i++) {
        Rx<TotpModel> totpModel = codeList[i];
        startCountdown(i, totpModel);
      }
    }
  }

  //  开始倒计时
  startCountdown(int index, Rx<TotpModel> totpModel) {
    String newCode = generateTOTPCode(totpModel.value.issuer!, totpModel.value.secret!);

    totpModel(totpModel.value.copyWith(code: newCode));
    AnimationController controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: (totpModel.value.initialTime ?? 30).toInt()), // 动画持续时间
    );

    // 先声明 animation 变量
    late Animation<double> animation;
    // 使用 Tween 创建从 1.0 到 0.0 的动画
    animation = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        totpModel(totpModel.value.copyWith(countdownTime: animation.value));
        codeList[index] = totpModel;

        // 监听动画变化并更新 UI
        if (animation.value <= 0.0) {
          newCode = generateTOTPCode(totpModel.value.issuer!, totpModel.value.secret!);
          totpModel(totpModel.value.copyWith(code: newCode));
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
  Future<dynamic> filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      final contents = await file.readAsString();
      logger.e(contents);
      List<TotpModel> totpMapList = TotpUrlUtils.splitTotp(contents);
      TotpModelBoxUtils().addTotpList(totpMapList);
      getCodeByDb();
    } else {
      // User canceled the picker
    }
  }
}
