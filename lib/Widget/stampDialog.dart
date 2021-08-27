import 'package:flutter/material.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/models/stamp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// 読み込んだスタンプ結果を表示するダイアログ
///
/// [stampDialog], 引数[context] [stamp]スタンプ情報
///                戻り値 [AlertDialog]ダイアログ（スタンプ画像.押された時間.OKボタン）
///
void stampDialog(BuildContext context, Stamp stamp) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                subtitle: Image.asset(stamp.stampNum.toString(),
                    fit: BoxFit.fitWidth),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.stampLoadingDateTime,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(dateFormat(stamp.createdAt),
                    style: TextStyle(
                        color: Colors.black, fontSize: 15, height: 2)),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          OutlinedButton(
            child: Text(AppLocalizations.of(context)!.ok),
            style: OutlinedButton.styleFrom(
              primary: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(color: Colors.blue),
            ),
            onPressed: () => Navigator.of(context).pop(1),
          )
        ],
      );
    },
  );
}
