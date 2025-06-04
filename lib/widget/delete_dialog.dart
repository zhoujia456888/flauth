import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class DeleteDialog extends StatelessWidget {
  final String dialogTitle;
  final String dialogContent;
  final Function() dialogAction;

  const DeleteDialog({super.key, required this.dialogTitle, required this.dialogContent, required this.dialogAction});

  @override
  Widget build(BuildContext context) {
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
            Text(dialogTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(height: 10),
            Text(dialogContent, textAlign: TextAlign.start, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    SmartDialog.dismiss();
                  },
                  child: Text("取消"),
                ),
                TextButton(onPressed: dialogAction, child: Text("确定")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
