import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import '../Widget/CameraButton.dart';
import '../Widget/qrDialog.dart';

// 状態が動的に変化するウィジェット（通信・データによって）
class QRSamplePage extends StatefulWidget {
  QRSamplePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _QRSamplePageState createState() => _QRSamplePageState();
}

class _QRSamplePageState extends State<QRSamplePage> {
  ScanResult scanResult;

  Future _scan() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'カメラへのアクセスが許可されていません!';
        });
      } else {
        result.rawContent = 'エラー: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (scanResult != null)
    // ダイアログを表示する
    WidgetsBinding.instance
        .addPostFrameCallback((_) => (qrDialog(context, scanResult)));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '右下のボタンをおしてね',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: CameraButton(
        onNavigate: _scan,
      ),
    );
  }
}
