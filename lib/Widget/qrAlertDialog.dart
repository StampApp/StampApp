import 'package:flutter/material.dart';

// QRの警告を表示するアラート
void qrAlertDialog(BuildContext context, String title, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(text),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('はい'),
            onPressed: () => Navigator.of(context).pop(1),
          ),
        ],
      );
    },
  );
}
