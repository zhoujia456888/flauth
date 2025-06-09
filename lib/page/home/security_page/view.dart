import 'dart:io';

import 'package:FlAuth/model/totp_model.dart';
import 'package:FlAuth/utils/TotpIconUtils.dart';
import 'package:FlAuth/widget/add_dialog.dart';
import 'package:FlAuth/widget/delete_dialog.dart';
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
              return logic.searchShowIndexList.contains(index)
                  ? Card(
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
                        onLongPress: () {
                          showLongPress(model);
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
                    )
                  : SizedBox();
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
    String? iconPath = TotpIconUtils().getIconPath(totpModel.value.issuer!);
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
        return AddDialog(
          addItemList: [
            AddDialogItem(
              title: '从二维码添加',
              icon: Icons.qr_code,
              onTapAction: () {
                SmartDialog.dismiss().then((_) => logic.scanCode());
              },
            ),
            AddDialogItem(
              title: '从文件添加',
              icon: Icons.file_present,
              onTapAction: () async {
                SmartDialog.dismiss().then((_) => logic.filePicker());
              },
            ),
          ],
        );
      },
    );
  }

  //长按
  void showLongPress( Rx<TotpModel> model) {
    SmartDialog.show(
      builder: (context) {
        return AddDialog(
          addItemList: [
            AddDialogItem(
              title: '删除安全码',
              icon: Icons.delete,
              onTapAction: () {
                SmartDialog.dismiss().then((_) => showDeleteDialog(model));
              },
            ),
            AddDialogItem(
              title: '编辑安全码',
              icon: Icons.edit_note,
              onTapAction: () async {
                SmartDialog.dismiss();
                //  SmartDialog.dismiss().then((_) => logic.filePicker());
              },
            ),
          ],
        );
      },
    );
  }

  showDeleteDialog(Rx<TotpModel> model) {
    SmartDialog.show(
      builder: (context) {
        return DeleteDialog(
          dialogTitle: '删除安全码',
          dialogContent: '确定要删除${model.value.issuer}安全码吗？删除之后没办法恢复哦！',
          dialogAction: () {
            SmartDialog.dismiss().then((_) => logic.deleteCode(model));
          },
        );
      },
    );
  }
}
