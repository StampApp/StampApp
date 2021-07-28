/* サンプル
軽い用語？集（大雑把な説明なのでイメージ程度でしか書いてないので詳しくは自分で調べてください）
* Widgetとはコンポーネント(部品)的なものというイメージ
* Stateとは値を変更すると動的に値が切り替わる変数というイメージ
* StatelessWidgetとは単語のままでState lessなWidget、Stateを使わないWidgetはこれで定義する
* StatefulWidgetとは上記の逆でStateを使うWidgetはこれで定義する
* Propsとは親から子に値を受け渡すための値
*/
import 'package:flutter/material.dart';
import 'package:stamp_app/Widget/AppBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyPolicyPage extends StatefulWidget {
  // コンストラクタで値を受け取るのと同じでいわゆるpropsのような使い方をする
  PrivacyPolicyPage({Key? key, required this.title}) : super(key: key);
  final String title;

  // 生成したStateをMyPageで使えるように
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

// state（動的に変化する変数）を生成する
class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    // Scaffoldは画面構成の基本Widget
    //デバイスのサイズ取得
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(deviceHeight * 0.08),
          child: AppBarPage(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 50,
        ),
        children: <Widget>[
          SizedBox(height: deviceHeight * 0.04),
          Text(AppLocalizations.of(context)!.privacyPolicyRead),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第1条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle1,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle1Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第2条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle2,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle2Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第3条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle3,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle3Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第4条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle4,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle4Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第5条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle5,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle5Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第6条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle6,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle6Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.withRules,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(AppLocalizations.of(context)!.privacyPolicyEnacted)
        ],
      ),
    );
  }
}
