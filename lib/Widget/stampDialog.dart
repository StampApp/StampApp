import 'package:flutter/material.dart';
import 'package:stamp_app/models/stamp.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                subtitle: Image.asset(stamp.stampNum.toString(),
                    fit: BoxFit.fitWidth),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.stampLoadingDateTime),
                subtitle: Text(dateFormat(stamp.createdAt)),
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

String dateFormat(createdAt) {
  //createdAtを「yyyy年MM月DD日(E)　hh:mm:ss」という表記に変更する関数
  initializeDateFormatting('ja');
  String data = DateFormat.yMMMEd('ja').format(createdAt).toString() + "　";
  data += DateFormat.jms('ja').format(createdAt).toString();
  return data;
}
