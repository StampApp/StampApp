import 'package:flutter/material.dart';
import 'package:stamp_app/View/home.dart';

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
                subtitle:
                    Image.asset('assets/images/my4.png', fit: BoxFit.fitWidth),
              ),
              ListTile(
                title: Text("stampNum"),
                subtitle: Text(stamp.stampNum.toString()),
              ),
              ListTile(
                title: Text("data"),
                subtitle: Text(stamp.data),
              ),
              ListTile(
                title: Text("createAt"),
                subtitle: Text(stamp.createAt),
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
