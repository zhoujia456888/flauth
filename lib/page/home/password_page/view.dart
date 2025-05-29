import 'package:FlAuth/model/password_model.dart';
import 'package:FlAuth/widget/add_dialog.dart';
import 'package:FlAuth/widget/delete_dialog.dart';
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
                        onLongPress: () {
                          showLongPress(model);
                        },
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

  // 密码项
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

  //  手动输入添加
  showInputOrEditPasswordDialog(bool isEdit, Rx<PasswordModel> model) {
    logic.inputTitleTxtController.text = model.value.title ?? "";
    logic.inputUrlTxtController.text = model.value.url ?? "";
    logic.inputUsernameTxtController.text = model.value.username ?? "";
    logic.inputPasswordTxtController.text = model.value.password ?? "";
    SmartDialog.show(
      builder: (context) {
        return Card(
          elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isEdit ? "编辑密码" : "添加密码"),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: '标题', border: OutlineInputBorder()),
                  controller: logic.inputTitleTxtController,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: '地址', border: OutlineInputBorder()),
                  controller: logic.inputUrlTxtController,
                  keyboardType: TextInputType.url,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: '用户名', border: OutlineInputBorder()),
                  controller: logic.inputUsernameTxtController,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: '密码', border: OutlineInputBorder()),
                  controller: logic.inputPasswordTxtController,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        SmartDialog.dismiss();
                      },
                      child: Text("取消"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (isEdit) {
                          logic.updatePassword(model);
                        } else {
                          logic.savePassword();
                        }
                      },
                      child: Text("确定"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //  选择添加方式
  void showAddDialog() {
    SmartDialog.show(
      builder: (context) {
        return AddDialog(
          addItemList: [
            AddDialogItem(
              title: '手动输入添加',
              icon: Icons.input,
              onTapAction: () {
                SmartDialog.dismiss().then((_) => showInputOrEditPasswordDialog(false, PasswordModel().obs));
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

  //长按
  void showLongPress(Rx<PasswordModel> model) {
    SmartDialog.show(
      builder: (context) {
        return AddDialog(
          addItemList: [
            AddDialogItem(
              title: '删除密码',
              icon: Icons.delete,
              onTapAction: () {
                SmartDialog.dismiss().then((_) => showDeleteDialog(model));
              },
            ),
            AddDialogItem(
              title: '编辑密码',
              icon: Icons.edit_note,
              onTapAction: () async {
                SmartDialog.dismiss().then((_) => showInputOrEditPasswordDialog(true, model));
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(Rx<PasswordModel> model) {
    SmartDialog.show(
      builder: (context) {
        return DeleteDialog(
          dialogTitle: "删除密码",
          dialogContent: "确定删除这个密码吗？删除之后没办法恢复哦！",
          dialogAction: () {
            SmartDialog.dismiss().then((_) => logic.deletePassword(model));
          },
        );
      },
    );
  }
}
