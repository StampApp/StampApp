import 'package:flutter/material.dart';

// スタンプの警告を表示するアラート
void stampMaxDialogAlert(BuildContext context, int maxStamp) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('警告'),
        content: Container(
          height: 320,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("注意"),
                subtitle: Text("スタンプが$maxStamp個貯まりました。\n交換してください。"),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(0),
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(1),
          ),
        ],
      );
    },
  );
}
