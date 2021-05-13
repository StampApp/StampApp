/*
メインコード
* このコードを変更する場合は基本的にページを追加する場合orルーティングを変える場合
* ページを追加する場合はimportしてroutesの中でルーティングパスとWidgetを定義する
*/
import 'package:flutter/material.dart';
import 'View/sample.dart';
import 'View/qrSample.dart';
import 'View/hometest.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stampアプリのサンプルアプリ',
      theme: ThemeData.light(), // ライト用テーマ
      darkTheme: ThemeData.dark(), // ダーク用テーマ
      themeMode: ThemeMode.system,
      // デフォルトルート
      initialRoute: '/',
      // 作成したページを呼び出す
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => SamplePage(title: 'スタンプアプリ'),
        '/homeTest': (BuildContext context) => HomeSamplePage(title: 'ホーム'),
        '/homeTest/qrReader': (BuildContext context) => QRSamplePage(title: 'QR読み込み')
      },
    );
  }
}