import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:stamp_app/Util/validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 読み込み結果を表示するダイアログ

Future<ScanResult> qrScan(BuildContext context) async {
  try {
    var result = await BarcodeScanner.scan();
    if (result.type.name == "Cancelled") {
      return result;
    }

    var manifestContent = await rootBundle.loadString('AssetManifest.json');
    Map<String, dynamic> manifestMap = json.decode(manifestContent);
    List<String> imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .toList();

    Map<String, dynamic> rowContent = json.decode(result.rawContent);

    if (!Validation.dateCheck(rowContent['createdAt']) ||
        !Validation.strCheck(rowContent['data']) ||
        !Validation.pathCheck(rowContent['stampNum'], imagePaths)) {
      result.rawContent =  AppLocalizations.of(context).dataIsIncorrect;
    }
    return result;
  } on PlatformException catch (e) {
    var result = ScanResult(
      type: ResultType.Error,
      format: BarcodeFormat.unknown,
    );
    if (e.code == BarcodeScanner.cameraAccessDenied) {
      result.rawContent = AppLocalizations.of(context).notAccessCamera;
    } else {
      result.rawContent = AppLocalizations.of(context).error + ': $e';
    }
    return result;
  } on FormatException catch (e) {
    var result = ScanResult(
      type: ResultType.Error,
      format: BarcodeFormat.unknown,
    );
    result.rawContent = AppLocalizations.of(context).error + ': ${e.message}';
    return result;
  }
}
