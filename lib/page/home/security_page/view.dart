import 'dart:io';

import 'package:FlAuth/model/totp_model/totp_model.dart';
import 'package:FlAuth/utils/TotpIconUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../../main.dart' show logger;
import 'logic.dart';

class SecurityPage extends StatelessWidget {
  SecurityPage({super.key});

  final SecurityLogic logic = Get.put(SecurityLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('安全码'),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
            },
            icon: Icon(Icons.brightness_4),
          ),
        ],
      ),
      body: Obx(
        () => ListView.custom(
          childrenDelegate: SliverChildBuilderDelegate((context, index) {
            Rx<TotpModel> model = logic.codeList[index];
            return Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (model.value.isShow ?? false) {
                    Clipboard.setData(ClipboardData(text: model.value.code!));
                    SmartDialog.showToast("安全码已复制到粘贴板");
                    model(model.value.copyWith(isShow: false));
                  } else {
                    model(model.value.copyWith(isShow: true));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 35, height: 35, child: creatTotpIcon(model)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text(model.value.issuer!), Text(model.value.userName!)],
                            ),
                          ),
                          Text((model.value.isShow ?? true) ? "${model.value.code}" : "".padLeft((model.value.code ?? "").length, "-")),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(value: model.value.countdownTime, borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 20,
                            child: Text("${((model.value.countdownTime ?? 0) * (model.value.initialTime ?? 0)).toInt()}"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }, childCount: logic.codeList.length),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showAddDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  creatTotpIcon(Rx<TotpModel> totpModel) async {
    String iconPath = TotpIconUtils.getIconPath(totpModel.value.issuer!)!;
    var byteData = await rootBundle.load(iconPath);
    if (byteData.lengthInBytes != 0) {
      return SvgPicture.asset(iconPath);
    } else if (totpModel.value.iconPath != null) {
      return Image.file(File(totpModel.value.iconPath!));
    } else {
      return Icon(Icons.person_outline);
    }
  }

  //添加totp
  showAddDialog() {
    SmartDialog.show(
      builder: (context) {
        return Container(
          height: 150,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(color: Get.theme.scaffoldBackgroundColor, borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(size: 24, Icons.qr_code),
                      SizedBox(width: 10),
                      Text("从二维码添加", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                onTap: () {
                  SmartDialog.dismiss().then(logic.scanCode());
                },
              ),
              SizedBox(height: 10),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(size: 24, Icons.file_present),
                      SizedBox(width: 10),
                      Text("从文件添加", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                onTap: () async {
                  SmartDialog.dismiss().then(await logic.filePicker());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
