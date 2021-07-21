import 'package:flutter/material.dart';

// スタンプの警告を表示するアラート
void stampMaxDialogAlert(BuildContext context, int maxStamp) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('スタンプが貯まりました'),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("スタンプが$maxStamp個貯まりました。\n交換してください。\n\n注:これ以上はスタンプを読み込めません。"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('はい'),
            style: OutlinedButton.styleFrom(
              primary: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(color: Colors.blue),
            ),
            onPressed: () => Navigator.of(context).pop(1),
          ),
        ],
      );
    },
  );
}
