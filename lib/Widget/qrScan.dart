import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stamp_app/Util/enumCheckString.dart';

// 読み込み結果を表示するダイアログ
Future<ScanResult> qrScan() async {
  try {
    var result = await BarcodeScanner.scan();
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

// 読み込んだQRを検証するクラス
class Validation {
  static final String stampCheckString = CheckString.ok.checkStringValue;
  static bool dateCheck(datetime) {
    DateTime verificationDate =
        DateFormat("yyyy/MM/dd HH:mm:ss").parseStrict(datetime);
    DateTime now = DateTime.now();

    if (now.isBefore(verificationDate)) return false;
    return true;
  }

  static bool strCheck(String content) {
    // 記号・半角を含まない
    if (RegExp(r'^(?=.*[!-/:-@[-`{-~]).*$').hasMatch(content)) return false;
    if (!content.contains(stampCheckString)) return false;
    if (content.contains('http')) return false;
    return true;
  }
}
