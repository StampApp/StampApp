/*
メインコード
* このコードを変更する場合は基本的にページを追加する場合orルーティングを変える場合
* ページを追加する場合はimportしてroutesの中でルーティングパスとWidgetを定義する
*/
import 'package:flutter/material.dart';
import 'View/sample.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stampアプリのサンプルアプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // デフォルトルート
      initialRoute: '/',
      // 作成したページを呼び出す
      routes: {
        '/': (_) => SamplePage(title: 'スタンプアプリ'),
      },
    );
  }
}