/*
メインコード
* このコードを変更する場合は基本的にページを追加する場合orルーティングを変える場合
* ページを追加する場合はimportしてroutesの中でルーティングパスとWidgetを定義する
*/
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'View/home.dart';
import 'View/terms.dart';
import 'View/Setting.dart';
import 'View/privacyPolicy.dart';
import 'View/history.dart';
import 'View/instructions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TODO: i18n対応
      title: 'Stampアプリのサンプルアプリ',
      theme: ThemeData.light(), // ライト用テーマ
      darkTheme: ThemeData.dark(), // ダーク用テーマ
      themeMode: ThemeMode.system,
      // デフォルトルート
      initialRoute: '/',
      // 作成したページを呼び出す
      routes: <String, WidgetBuilder>{
        // TODO: i18n対応　titleはi18n対応したものを渡せば各ページでタイトルの文をページごとに定義しなくていいのでは？
        '/': (BuildContext context) =>
            HomeSamplePage(title: 'スタンプアプリ', routeObserver: _routeObserver),
        '/Setting': (BuildContext context) => SettingPage(title: '設定'),
        '/history': (BuildContext context) => HistoryPage(title: '利用履歴'),
        '/terms': (BuildContext context) => TermsPage(title: '利用規約'),
        '/instructions': (BuildContext context) =>
            InstructionsPage(title: '使い方'),
        '/privacyPolicy': (BuildContext context) =>
            PrivacyPolicyPage(title: 'プライバシーポリシー'),
      },
      localizationsDelegates: [
        // localizations delegateを追加
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // 英語
        const Locale('ja', ''), // 日本語
      navigatorObservers: [
        _routeObserver,
      ],
    );
  }
}
