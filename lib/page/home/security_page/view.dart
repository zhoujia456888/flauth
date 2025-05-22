import 'package:FlAuth/config/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
            final model = logic.codeList[index];
            return Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 35, height: 35, child: SvgPicture.asset(model.iconPath!)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(model.issuer!), Text(model.userName!)],
                          ),
                        ),
                        Text(model.code ?? "--"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(value: model.countdownTime, borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(width: 10),
                        SizedBox(width: 20, child: Text("${((model.countdownTime ?? 0) * (model.initialTime ?? 0)).toInt()}")),
                      ],
                    ),
                  ],
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
                onTap: () {
                  SmartDialog.dismiss().then(logic.filePicker());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
