import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// 読み込み結果を表示するダイアログ
Future<ScanResult> qrScan() async {
  try {
    var result = await BarcodeScanner.scan();
    Map<String, dynamic> rowContent = json.decode(result.rawContent);

    bool dateCheckResult = Validation.dateCheck(rowContent['date']);
    bool strCheckResult = Validation.strCheck(rowContent['str']);

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
  static bool dateCheck(content) {
    DateTime now = DateTime(2021, 6, 1);
    DateFormat outputFormat = DateFormat('yyyy/MM/dd');
    String date = outputFormat.format(now);

    return date == content ? true : false;
  }

  static bool strCheck(content) {
    return content.contains('stamp');
  }
}
/*
ScanResult
format:BarcodeFormat (qr)
formatNote:""
rawContent:"https://ja.wikipedia.org/"
type:ResultType (Barcode)
hashCode:120338450
runtimeType:Type (ScanResult)
format:BarcodeFormat (qr)
formatNote:""
rawContent:"https://ja.wikipedia.org/"
type:ResultType (Barcode)
hashCode:120338450
runtimeType:Type (ScanResult)
*/
