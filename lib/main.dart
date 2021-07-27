/*
メインコード
* このコードを変更する場合は基本的にページを追加する場合orルーティングを変える場合
* ページを追加する場合はimportしてroutesの中でルーティングパスとWidgetを定義する
*/
import 'package:flutter/material.dart';
import 'package:stamp_app/View/qrScan.dart';
import 'View/home.dart';
import 'View/terms.dart';
import 'View/Setting.dart';
import 'View/privacyPolicy.dart';
import 'View/history.dart';
import 'View/instructions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();
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
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => HomeSamplePage(
            title: AppLocalizations.of(context)!.stampApp,
            routeObserver: _routeObserver),
        // TODO: i18n 対応
        '/qrScan': (BuildContext context) => QRCodeScanner(title: 'QR読み取り'),
        '/Setting': (BuildContext context) =>
            SettingPage(title: AppLocalizations.of(context)!.settings),
        '/history': (BuildContext context) =>
            HistoryPage(title: AppLocalizations.of(context)!.usageHistory),
        '/terms': (BuildContext context) =>
            TermsPage(title: AppLocalizations.of(context)!.termsOfUse),
        '/instructions': (BuildContext context) =>
            InstructionsPage(title: AppLocalizations.of(context)!.usage),
        '/privacyPolicy': (BuildContext context) => PrivacyPolicyPage(
            title: AppLocalizations.of(context)!.privacyPolicy),
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
      ],
      navigatorObservers: [
        _routeObserver,
      ],
    );
  }
}
