import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:stamp_app/Util/validation.dart';

// 読み込み結果を表示するダイアログ
Future<ScanResult> qrScan() async {
  try {
    var result = await BarcodeScanner.scan();
    if (result.type.name == "Cancelled") {
      return result;
    }
    Map<String, dynamic> rowContent = json.decode(result.rawContent);

    if (!Validation.dateCheck(rowContent['createdAt']) ||
        !Validation.strCheck(rowContent['data'])) {
      result.rawContent = 'データが不正です';
    }
    return result;
  } on PlatformException catch (e) {
    var result = ScanResult(
      type: ResultType.Error,
      format: BarcodeFormat.unknown,
    );
    if (e.code == BarcodeScanner.cameraAccessDenied) {
      result.rawContent = 'カメラへのアクセスが許可されていません!';
    } else {
      result.rawContent = 'エラー: $e';
    }
    return result;
  } on FormatException catch (e) {
    var result = ScanResult(
      type: ResultType.Error,
      format: BarcodeFormat.unknown,
    );
    result.rawContent = 'エラー: ${e.message}';
    return result;
  }
}
