import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stamp_app/Constants/setting.dart';
import 'package:stamp_app/Util/Enums/enumCheckString.dart';
import 'package:stamp_app/Util/validation.dart';
import 'package:stamp_app/Widget/HexColor.dart';
import 'package:stamp_app/dbHelper.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:stamp_app/models/stamp.dart';
import 'package:stamp_app/models/stampLogs.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@immutable
class ConfirmArguments {
  const ConfirmArguments(
      {required this.type, required this.format, required this.data});
  final String type;
  final String format;
  final String data;
}

@immutable
class ResultArguments {
  const ResultArguments(
      {required this.result, required this.title, required this.data});
  final String result;
  final String title;
  final String data;
}

class ScanResult {
  String type;
  BarcodeFormat? format;
  String? rawContent;
  ScanResult({
    this.type = "",
    this.rawContent = "",
    this.format = BarcodeFormat.unknown,
  })  : assert(rawContent != null),
        assert(format != null);
}

class QRCodeScanner extends StatefulWidget {
  QRCodeScanner({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  QRViewController? _qrController;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  bool _isQRScanned = false;
  static final String stampCheckString = CheckString.ok.checkStringValue!;
  static final uuid = Uuid();

  // ホットリロードを機能させるには、プラットフォームがAndroidの場合はカメラを一時停止するか、
  // プラットフォームがiOSの場合はカメラを再開する必要がある
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrController?.pauseCamera();
    }
    _qrController?.resumeCamera();
  }

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          ResultArguments none = new ResultArguments(
              result: "backButton", title: "none", data: "none");
          Navigator.of(context).pop(none);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: HexColor(Setting.APP_COLOR),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: _buildQRView(context),
              ),
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(AppLocalizations.of(context)!.cameraSetting),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () async {
                                await _qrController?.toggleFlash();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: _qrController?.getFlashStatus(),
                                builder: (context, snapshot) => Text(
                                    AppLocalizations.of(context)!.flash +
                                        ': ${snapshot.data}'),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () async {
                                await _qrController?.flipCamera();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: _qrController?.getCameraInfo(),
                                builder: (context, snapshot) =>
                                    snapshot.data != null
                                        ? Text(AppLocalizations.of(context)!
                                                .cameraSwitching +
                                            ': ${describeEnum(snapshot.data!)}')
                                        : const Text('loading'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildQRView(BuildContext context) {
    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green,
        borderRadius: 16,
        borderLength: 24,
        borderWidth: 8,
        // cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() {
      _qrController = qrController;
    });
    // QRを読み込みをlistenする
    qrController.scannedDataStream.listen((scanData) async {
      // QRのデータが取得出来ない場合SnackBar表示
      // if (scanData.code == null) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('QR code data does not exist'),
      //     ),
      //   );
      // }
      final data = await scanValidation(scanData);
      _transitionToNextScreen('', describeEnum(data.format as BarcodeFormat),
          data.rawContent as String);
    });
  }

  // 元の画面へ遷移
  Future<void> _transitionToNextScreen(
      String type, String format, String data) async {
    if (!_isQRScanned) {
      // カメラを一時停止
      _qrController?.pauseCamera();
      _isQRScanned = true;

      if (data != "データが不正です" && format != describeEnum(BarcodeFormat.unknown)) {
        dynamic resultJson = json.decode(data);

        if (format == describeEnum(BarcodeFormat.qrcode) &&
            resultJson["data"] == stampCheckString) {
          DateTime dateTime = DateTime.now();
          Stamp newStamp = new Stamp(
              id: uuid.v1(),
              data: resultJson["data"],
              getDate: dateTime,
              getTime: dateTime,
              stampNum: resultJson["stampNum"],
              useFlg: false,
              createdAt: dateTime,
              deletedAt: dateTime);
          await DbInterface.insert('Stamp', DBHelper.databese(), newStamp);

          // LOG 記録
          StampLogs newLogs = new StampLogs(
            id: uuid.v1(),
            stampId: newStamp.id,
            getDate: dateTime,
            getTime: dateTime,
            useFlg: false,
            createdAt: dateTime,
          );

          await DbInterface.insert('StampLogs', DBHelper.databese(), newLogs);
          // 元の画面へ遷移
          Navigator.of(context)
              .pop(ResultArguments(result: "ok", title: "none", data: data));
        } else {
          String title = AppLocalizations.of(context)!.error;
          String text = format != describeEnum(BarcodeFormat.qrcode)
              ? AppLocalizations.of(context)!.notQRCode
              : AppLocalizations.of(context)!.invalidQRCode;
          // 元の画面へ遷移
          Navigator.of(context)
              .pop(ResultArguments(result: "err", title: title, data: text));
        }
      } else {
        String title = AppLocalizations.of(context)!.error;
        String text = AppLocalizations.of(context)!.illegalQRCode + '\n$data';
        // 元の画面へ遷移
        Navigator.of(context)
            .pop(ResultArguments(result: "err", title: title, data: text));
      }
    }
  }

  // 読み込み結果を表示するダイアログ
  Future<ScanResult> scanValidation(Barcode scanData) async {
    try {
      var result = new ScanResult(format: BarcodeFormat.qrcode, rawContent: '');

      if (scanData.format != BarcodeFormat.qrcode) {
        result.format = scanData.format;
        result.rawContent = AppLocalizations.of(context)!.incorrectData;
      }

      var manifestContent = await rootBundle.loadString('AssetManifest.json');
      Map<String, dynamic> manifestMap = json.decode(manifestContent);
      List<String> imagePaths = manifestMap.keys
          .where((String key) => key.contains('images/'))
          .toList();

      Map<String, dynamic> rowContent = json.decode(scanData.code);

      if (!Validation.dateCheck(rowContent['createdAt']) ||
          !Validation.strCheck(rowContent['data']) ||
          !Validation.pathCheck(rowContent['stampNum'], imagePaths)) {
        result.rawContent = AppLocalizations.of(context)!.incorrectData;
      } else {
        result.rawContent = scanData.code;
      }
      return result;
    } on PlatformException catch (e) {
      var result = ScanResult(
          format: BarcodeFormat.unknown,
          rawContent: AppLocalizations.of(context)!.incorrectData);
      result.rawContent =
          AppLocalizations.of(context)!.error + ': ${e.message}';
      return result;
    } on FormatException catch (e) {
      var result = ScanResult(
          format: BarcodeFormat.unknown,
          rawContent: AppLocalizations.of(context)!.incorrectData);
      result.rawContent =
          AppLocalizations.of(context)!.error + ': ${e.message}';
      return result;
    }
  }
}
