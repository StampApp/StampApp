# widget とは

widget とは、Flutter アプリの UI を構築するパーツです。

## qrAlertDialog.dart の使い方

正常な QR コード以外を読み込んだ場合に警告文をポップアップで表示させる Widget です。

```dart
//importします
import import 'package:stamp_app/Widget/qrAlertDialog.dart';

//QRコードの情報判定時用意されているQRコード出なければダイアログを表示できます
if (result.result == "err") {
    qrAlertDialog(context, result.title, result.data);
}
```

​

## stampIcons.dart の使い方

​
オリジナルのスタンプアイコンを使用できるようにする Widget です。
この度のアイコンは、スタンプを押しているのをイメージしたアイコンになります。
[こちらを参考にしました](https://techracho.bpsinc.jp/wingdoor/2020_06_05/92667)
​

```Dart
//まずはこのようにimportします
import 'package:stamp_app/Widget/stampIcons.dart';
​
//使用したい箇所で呼び出してあげます
Icon(StampIcon.stamp),
//もしエラーが出る場合は、'pubspec.yaml'にある↓の画像位置が正しいか確認してください
fonts:
  - family: StampIcon
    fonts:
      - asset: assets/images/other/StampIcon.ttf
```

## stampDialog.dart の使い方

​
スタンプのイメージをタップした時に表示するダイアログを生成する Widget です。
​

```Dart
//まずはこのようにimportします
import '../Widget/stampDialog.dart';
​
//使用したい箇所で呼び出します（ダイアログが表示されるようになります）
onTap: () => stamp.data == stampCheckString
    ? stampDialog(context, stamp)
    : (context),
```

​

## stampMaxDialog.dart の使い方

スタンプ数が上限に達した時に表示するダイアログを生成する Widget です。
​

```Dart
//まずはこのようにimportします
import '../Widget/stampMaxDialog.dart';
​
//使用したい箇所で呼び出します（ダイアログが表示されるようになります）
stampMaxDialogAlert(context, maxStamp);
```

## AppBar.dart の使い方

​
単一化されたヘッダーを仕様変更時に楽に書き換えできるようにした Widget です。
ただし、統一したヘッダーでない場合（今回は `home.dart` ）は、こちらを使用しないようにしてください。
​

```Dart
//まずはこのようにimportします
import 'package:stamp_app/Widget/AppBar.dart';
​
//使用したい箇所で呼び出してあげます（これだとmain.dartで設定したタイトルがヘッダーに表示されるようになります）
AppBarPage(widget.title)
//（例）↓のようにPreferredSize（Appbarの高さをいじれる）の中に記述した方がより実用的になります。
appBar: PreferredSize(
    preferredSize: Size.fromHeight(deviceHeight * 0.08),
    AppBarPage(widget.title)
)
```

---

## 今後拡張していくにあたって

​
今後ヘッダーの書き換えにあたって、`home.dart`のように統一でなくなるものにはこちらは使用しない方がいいでしょう。
