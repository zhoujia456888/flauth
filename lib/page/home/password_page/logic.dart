import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:FlAuth/model/password_model.dart';
import 'package:FlAuth/objectBox/passwordModelBoxUtils.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl;

import '../../../main.dart';

class PasswordLogic extends GetxController {
  RxList<Rx<PasswordModel>> passwordModelList = <Rx<PasswordModel>>[].obs;

  final searchShowIndexList = <int>[].obs;

  TextEditingController inputTitleTxtController = TextEditingController();
  TextEditingController inputUrlTxtController = TextEditingController();
  TextEditingController inputUsernameTxtController = TextEditingController();
  TextEditingController inputPasswordTxtController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getPassWordByDb();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getPassWordByDb() {
    passwordModelList.clear();
    List<PasswordModel> passwordList = PasswordModelBoxUtils().getAllPassword();
    for (int i = 0; i < passwordList.length; i++) {
      PasswordModel passwordModel = passwordList[i];
      passwordModelList.add(Rx(passwordModel));
      searchShowIndexList.add(i);
    }
  }

  //  搜索
  void searchPassWord(String searchText) {
    searchShowIndexList.clear();
    searchText = searchText.toLowerCase();
    if (searchText.isEmpty) {
      cleanSearch();
      return;
    }

    for (int i = 0; i < passwordModelList.length; i++) {
      if ((passwordModelList[i].value.title ?? "").toLowerCase().contains(searchText) ||
          (passwordModelList[i].value.url ?? "").toLowerCase().contains(searchText) ||
          (passwordModelList[i].value.username ?? "").toLowerCase().contains(searchText)) {
        searchShowIndexList.add(i);
        searchShowIndexList.refresh();
      }
    }
    passwordModelList.refresh();
  }

  //  清空搜索
  void cleanSearch() {
    searchShowIndexList.clear();
    for (int i = 0; i < passwordModelList.length; i++) {
      searchShowIndexList.add(i);
      searchShowIndexList.refresh();
    }
    passwordModelList.refresh();
  }

  Future<dynamic> filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      await converterCsvToJson(file);
    } else {
      SmartDialog.showToast("未选择任何文件");
      logger.e("未选择任何文件");
    }
  }

  converterCsvToJson(File file) async {
    try {
      // 读取 CSV 文件内容并转换为 List<List<String>>
      final inputStream = file.openRead();
      final csvData = await inputStream.transform(utf8.decoder).transform(CsvToListConverter()).toList();

      // 去除表头
      final List<List<dynamic>> rows = csvData;

      // 第一行作为 header
      final List<dynamic> headers = rows.first;

      List<PasswordModel> passwordModelList = [];

      // 转换每一行数据为 Map
      for (int i = 1; i < rows.length; i++) {
        final row = rows[i];
        if (row.length == headers.length) {
          final Map<String, dynamic> rowMap = {};
          for (int j = 0; j < headers.length; j++) {
            rowMap[headers[j].toString()] = row[j];
            logger.d("rowMap: $rowMap");
          }
          passwordModelList.add(
            PasswordModel(
              title: rowMap['name'].toString(),
              username: rowMap['username'].toString(),
              password: rowMap['password'].toString(),
              url: rowMap['url'].toString(),
              isShow: false,
            ),
          );
        } else {
          logger.e("跳过格式不匹配的行：$row");
        }
      }
      PasswordModelBoxUtils().addPasswordList(passwordModelList);
      getPassWordByDb();
    } catch (e) {
      logger.e("文件解析失败：$e");
    }
  }

  //跳转到浏览器打开地址
  Future<void> openUrl(String contentText) async {
    if (!contentText.startsWith("http")) {
      SmartDialog.showToast("请输入正确的网址");
    }

    if (!await launchUrl(Uri.parse(contentText))) {
      throw Exception('Could not launch $contentText');
    }
  }

  savePassword() {
    String inputTitleTxt = inputTitleTxtController.text;
    String inputUrlTxt = inputUrlTxtController.text;
    String inputUsernameTxt = inputUsernameTxtController.text;
    String inputPasswordTxt = inputPasswordTxtController.text;
    if (inputTitleTxt.isEmpty || inputUrlTxt.isEmpty || inputUsernameTxt.isEmpty || inputPasswordTxt.isEmpty) {
      SmartDialog.showToast("请填写完整密码信息");
      return;
    }

    int putId = PasswordModelBoxUtils().addPassword(
      PasswordModel(title: inputTitleTxt, url: inputUrlTxt, username: inputUsernameTxt, password: inputPasswordTxt, isShow: false),
    );
    if (putId >= 0) {
      SmartDialog.dismiss();
      SmartDialog.showToast("保存成功");
      inputTitleTxtController.clear();
      inputUrlTxtController.clear();
      inputUsernameTxtController.clear();
      inputPasswordTxtController.clear();
      getPassWordByDb();
    } else {
      SmartDialog.showToast("保存失败");
    }
  }

  //  删除密码
  void deletePassword(Rx<PasswordModel> model) {
    logger.d("删除密码：${model.value.title}");
    bool isDelete = PasswordModelBoxUtils().deletePassword(model.value);
    if (isDelete) {
      SmartDialog.showToast("删除成功");
      getPassWordByDb();
    } else {
      SmartDialog.showToast("删除失败");
    }
  }

  //  修改密码
  void updatePassword(Rx<PasswordModel> model) {
    String inputTitleTxt = inputTitleTxtController.text;
    String inputUrlTxt = inputUrlTxtController.text;
    String inputUsernameTxt = inputUsernameTxtController.text;
    String inputPasswordTxt = inputPasswordTxtController.text;
    if (inputTitleTxt.isEmpty || inputUrlTxt.isEmpty || inputUsernameTxt.isEmpty || inputPasswordTxt.isEmpty) {
      SmartDialog.showToast("请填写完整密码信息");
      return;
    }

    model.value = model.value.copyWith(title: inputTitleTxt, url: inputUrlTxt, username: inputUsernameTxt, password: inputPasswordTxt)!;
    int isUpdate = PasswordModelBoxUtils().updatePassword(model.value);
    if (isUpdate >= 0) {
      SmartDialog.dismiss();
      SmartDialog.showToast("修改成功");
      inputTitleTxtController.clear();
      inputUrlTxtController.clear();
      inputUsernameTxtController.clear();
      inputPasswordTxtController.clear();
      getPassWordByDb();
    } else {
      SmartDialog.showToast("修改失败");
    }
  }
}
