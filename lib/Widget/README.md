# widgetの説明
## HexColor
アプリで使用したい色をカラーコードで指定できるWidget
```
//importします
import 'package:stamp_app/Widget/HexColor.dart';

//色を指定したいところで使用
color: HexColor('FFFFFF')
```

## qrAlertDialog
正常なQRコード以外を読み込んだ場合に警告文をポップアップで表示させるWidget
```
//importします
import import 'package:stamp_app/Widget/qrAlertDialog.dart';

//QRコードの情報判定時用意されているQRコード出なければダイアログを表示できます
if (result.result == "err") {
    qrAlertDialog(context, result.title, result.data);
}
```
## SettingButton
Appbar右上の設定画面へ遷移するボタンを作成しているWidget


## CameraButton
画面右下に表示されているQRコード読み取りのカメラを起動するボタンを作成するWidget



