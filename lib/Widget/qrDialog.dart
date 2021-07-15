import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 読み込み結果を表示するダイアログ
void qrDialog(BuildContext context, ScanResult scanResult) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context).readResult),
        content: Container(
          height: 320,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Result Type"),
                subtitle: Text(scanResult.type?.toString() ?? ""),
              ),
              ListTile(
                title: Text("RawContent"),
                subtitle: Text(scanResult.rawContent ?? ""),
              ),
              ListTile(
                title: Text("Format"),
                subtitle: Text(scanResult.format?.toString() ?? ""),
              ),
              ListTile(
                title: Text("Format note"),
                subtitle: Text(scanResult.formatNote ?? ""),
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
