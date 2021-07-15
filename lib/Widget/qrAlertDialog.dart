import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// QRの警告を表示するアラート
void qrAlertDialog(BuildContext context, String title, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context).error),
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
            child: Text(AppLocalizations.of(context).yes),
            onPressed: () => Navigator.of(context).pop(1),
          ),
        ],
      );
    },
  );
}
