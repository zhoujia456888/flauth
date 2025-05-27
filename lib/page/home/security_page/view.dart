import 'dart:io';

import 'package:FlAuth/model/totp_model/totp_model.dart';
import 'package:FlAuth/utils/TotpIconUtils.dart';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'logic.dart';

class SecurityPage extends StatelessWidget {
  SecurityPage({super.key});

  final SecurityLogic logic = Get.put(SecurityLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        fieldHintText: "搜索",
        onChanged: (text) {
          logic.searchCode(text);
        },
        onCleared: () {
          logic.cleanSearch();
        },
        onClosed: () {
          logic.cleanSearch();
        },

        appBarBuilder: (context) {
          return AppBar(
            title: Text('安全码'),
            actions: [
              AppBarSearchButton(),
              // or
              //IconButton(onPressed: AppBarWithSearchSwitch.of(context) != null?startSearch, icon: Icon(Icons.search)),
            ],
          );
        },
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              logic.getCodeByDb();
              return Future.value(true);
            });
          },
          child: ListView.custom(
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              Rx<TotpModel> model = logic.codeList[index];
              return logic.searchShowIndexList.contains(index)?Card(
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
                    logic.awaitHideCode(model);
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
                            Text(logic.handleCode(model.value), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        SizedBox(height: 10),
                        LinearProgressIndicator(value: model.value.countdownTime, borderRadius: BorderRadius.circular(10)),
                      ],
                    ),
                  ),
                ),
              ):SizedBox();
            }, childCount: logic.codeList.length),
          ),
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

  Widget creatTotpIcon(Rx<TotpModel> totpModel) {
    String? iconPath = TotpIconUtils.getIconPath(totpModel.value.issuer!);
    if (iconPath != null) {
      return Image.asset(iconPath);
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
