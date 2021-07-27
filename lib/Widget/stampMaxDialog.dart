import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// スタンプの警告を表示するアラート
void stampMaxDialogAlert(BuildContext context, int maxStamp) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context).stampCollected),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context).maxStamp(maxStamp) +
                  '\n' +
                  AppLocalizations.of(context).pleaseExchange +
                  '\n' +
                  '\n\n' +
                  AppLocalizations.of(context).noMoreStamps),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context).yes),
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
