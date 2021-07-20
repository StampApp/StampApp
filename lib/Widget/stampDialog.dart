import 'package:flutter/material.dart';
import 'package:stamp_app/models/stamp.dart';

// 読み込み結果を表示するダイアログ
void stampDialog(BuildContext context, Stamp stamp) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          // height: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Image"),
                subtitle: Image.asset(stamp.stampNum.toString(),
                    fit: BoxFit.fitWidth),
              ),
              ListTile(
                title: Text("スタンプ読み込み日時"),
                subtitle: Text(stamp.createdAt.year.toString() +
                    "年" +
                    stamp.createdAt.month.toString() +
                    "月" +
                    stamp.createdAt.day.toString() +
                    "日 " +
                    stamp.createdAt.hour.toString() +
                    "時" +
                    stamp.createdAt.minute.toString() +
                    "分" +
                    stamp.createdAt.second.toString() +
                    "秒"),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(1),
          ),
        ],
      );
    },
  );
}
