import 'dart:convert';
import 'dart:io';
import 'package:FlAuth/model/password_model.dart';
import 'package:FlAuth/objectBox/passwordModelBoxUtils.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl;

import '../../../main.dart';

class PasswordLogic extends GetxController {
  RxList<Rx<PasswordModel>> passwordModelList = <Rx<PasswordModel>>[].obs;

  final searchShowIndexList = <int>[].obs;

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
    }
    for (int i = 0; i < passwordModelList.length; i++) {
      if ((passwordModelList[i].value.title ?? "").toLowerCase().contains(searchText) ||
          (passwordModelList[i].value.url ?? "").toLowerCase().contains(searchText) ||
          (passwordModelList[i].value.username ?? "").toLowerCase().contains(searchText)) {
        searchShowIndexList.add(i);
        searchShowIndexList.refresh();
        update();
      }
    }
  }

  //  清空搜索
  void cleanSearch() {
    searchShowIndexList.clear();
    for (int i = 0; i < passwordModelList.length; i++) {
      searchShowIndexList.add(i);
    }
  }

  toInputPassWord() {}

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
}
