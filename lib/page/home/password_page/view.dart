import 'package:FlAuth/model/password_model.dart';
import 'package:FlAuth/widget/add_dialog.dart';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({super.key});

  final PasswordLogic logic = Get.put(PasswordLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        fieldHintText: "搜索",
        onChanged: (text) {
          logic.searchPassWord(text);
        },
        onCleared: () {
          logic.cleanSearch();
        },
        onClosed: () {
          logic.cleanSearch();
        },

        appBarBuilder: (context) {
          return AppBar(title: Text('密码'), actions: [AppBarSearchButton()]);
        },
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              logic.getPassWordByDb();
              return Future.value(true);
            });
          },
          child: ListView.custom(
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              Rx<PasswordModel> model = logic.passwordModelList[index];
              bool searchIndex = logic.searchShowIndexList.contains(index);
              return searchIndex
                  ? Card(
                      elevation: 0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(model.value.title ?? ""),
                              passWordItem("地址", model.value.url ?? "", showOpenIcon: (model.value.url ?? "").startsWith("http")),
                              passWordItem("用户名", model.value.username ?? ""),
                              passWordItem(
                                "密码",
                                model.value.password ?? "",
                                showContext: model.value.isShow ?? false,
                                showHideIcon: true,
                                itemIndex: index,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox();
            }, childCount: logic.passwordModelList.length),
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

  passWordItem(
    String titleText,
    String contentText, {
    bool showOpenIcon = false,
    bool showContext = true,
    bool showHideIcon = false,
    int itemIndex = 0,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: Text("$titleText:  ${showContext ? contentText : "******"}", maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        Spacer(),
        showOpenIcon
            ? InkWell(
                borderRadius: BorderRadius.circular(20),
                child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.open_in_new, size: 18)),
                onTap: () {
                  logic.openUrl(contentText);
                },
              )
            : SizedBox(),
        showHideIcon
            ? InkWell(
                borderRadius: BorderRadius.circular(20),
                child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.visibility, size: 18)),
                onTap: () {
                  Rx<PasswordModel> model = logic.passwordModelList[itemIndex];
                  model(model.value.copyWith(isShow: !(model.value.isShow ?? false)));
                  logic.passwordModelList[itemIndex] = model;
                },
              )
            : SizedBox(),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.copy, size: 18)),
          onTap: () {
            Clipboard.setData(ClipboardData(text: contentText));
            SmartDialog.showToast("$titleText复制成功");
          },
        ),
      ],
    );
  }

  void showAddDialog() {
    SmartDialog.show(
      builder: (context) {
        return AddDialog(
          addItemList: [
            AddDialogItem(
              title: '手动输入添加',
              icon: Icons.qr_code,
              onTapAction: () {
                SmartDialog.dismiss().then((_) => logic.toInputPassWord());
              },
            ),
            AddDialogItem(
              title: '从文件添加',
              icon: Icons.file_present,
              onTapAction: () {
                SmartDialog.dismiss().then((_) => logic.filePicker());
              },
            ),
          ],
        );
      },
    );
  }
}
