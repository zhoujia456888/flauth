import 'dart:io';

import 'package:FlAuth/objectBox/totpModelBoxUtils.dart';
import 'package:auth_totp/auth_totp.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:steam_totp/steam_totp.dart';

import '../../../config/get_pages.dart';
import '../../../main.dart';
import '../../../model/totp_model.dart';
import '../../../utils/TotpUrlUtils.dart';

class SecurityLogic extends GetxController with GetTickerProviderStateMixin {
  //安全码列表
  RxList<Rx<TotpModel>> codeList = <Rx<TotpModel>>[].obs;

  final _isAutoHideCode = false.obs; //是否自动隐藏密码
  get isAutoHideCode => _isAutoHideCode.value; //
  set isAutoHideCode(val) => _isAutoHideCode.value = val; //

  final searchShowIndexList = <int>[].obs; //搜索隐藏的索引

  @override
  void onInit() {
    isAutoHideCode = spUtil.getBool("isAutoHideCode") ?? false;
    super.onInit();
  }

  @override
  void onReady() {
    getCodeByDb();
    super.onReady();
  }

  // 处理安全码显示
  String handleCode(TotpModel totpModel) {
    int length = totpModel.code?.length ?? 0;

    if (isAutoHideCode && !(totpModel.isShow ?? false)) {
      return "".padLeft(length, "-");
    } else {
      return totpModel.code!;
    }
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
    codeList.clear();
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
        searchShowIndexList.add(i);
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
        try {
          codeList[index] = totpModel;
        } catch (e) {
          logger.e(e);
        }

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
      List<TotpModel> totpMapList = TotpUrlUtils.splitTotp(data);
      if (totpMapList.isEmpty) {
        SmartDialog.showToast("未识别到安全码内容");
        return;
      }
      TotpModelBoxUtils().addTotpList(totpMapList);
      getCodeByDb();
    } else {
      SmartDialog.showToast("未识别到二维码内容");
    }
  }

  //文件选择
 filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      final contents = await file.readAsString();
      logger.e(contents);
      List<TotpModel> totpMapList = TotpUrlUtils.splitTotp(contents);
      TotpModelBoxUtils().addTotpList(totpMapList);
      getCodeByDb();
    } else {
      SmartDialog.showToast("未选择任何文件");
      logger.e("未选择任何文件");
    }
  }

  // 隐藏安全码
  void awaitHideCode(Rx<TotpModel> model) {
    Future.delayed(Duration(seconds: 5), () {
      model(model.value.copyWith(isShow: false));
    });
  }

  //搜索安全码
  void searchCode(String searchText) {
    searchShowIndexList.clear();
    searchText = searchText.toLowerCase();
    if (searchText.isEmpty) {
      cleanSearch();
    }
    for (int i = 0; i < codeList.length; i++) {
      if (codeList[i].value.issuer!.toLowerCase().contains(searchText) ||
          codeList[i].value.userName!.toLowerCase().contains(searchText)) {
        searchShowIndexList.add(i);
      }
    }
  }

  //  清空搜索
  void cleanSearch() {
    searchShowIndexList.clear();
    for (int i = 0; i < codeList.length; i++) {
      searchShowIndexList.add(i);
    }
  }
}
