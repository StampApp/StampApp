import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// 読み込み結果を表示するダイアログ
Future<ScanResult> qrScan() async {
  try {
    var result = await BarcodeScanner.scan();
    Map<String, dynamic> rowContent = json.decode(result.rawContent);

    if (!Validation.dateCheck(rowContent['date'], rowContent['time']) ||
        !Validation.strCheck(rowContent['str'])) {
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
  }
}

class Validation {
  static bool dateCheck(date, time) {
    DateTime verificationDate = DateTime(2021, 6, 1, 12, 0, 0);
    if (date != DateFormat('yyyy/MM/dd').format(verificationDate)) return false;
    if (time != DateFormat('HH:mm:ss').format(verificationDate)) return false;
    return true;
  }

  static bool strCheck(String content) {
    // 記号・半角を含まない
    if (RegExp(r'^(?=.*[!-/:-@[-`{-~]).*$').hasMatch(content)) return false;
    if (!content.contains('stamp')) return false;
    if (content.contains('http')) return false;
    return true;
  }
}
