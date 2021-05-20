/* サンプル
軽い用語？集（大雑把な説明なのでイメージ程度でしか書いてないので詳しくは自分で調べてください）
* Widgetとはコンポーネント(部品)的なものというイメージ
* Stateとは値を変更すると動的に値が切り替わる変数というイメージ
* StatelessWidgetとは単語のままでState lessなWidget、Stateを使わないWidgetはこれで定義する
* StatefulWidgetとは上記の逆でStateを使うWidgetはこれで定義する
* Propsとは親から子に値を受け渡すための値
*/
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  // コンストラクタで値を受け取るのと同じでいわゆるpropsのような使い方をする
  PrivacyPolicyPage({Key key, this.title}) : super(key: key);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        children: <Widget>[
          SizedBox(height: 25),

          Text(
              'このプライバシーポリシー（以下、「本ポリシー」といいます。）は、＿＿＿＿＿（以下、「当社」といいます。）がこのアプリケーション上で提供するサービス（以下、「本サービス」といいます。）の利用条件を定めるものです。登録ユーザーの皆さま（以下、「ユーザー」といいます。）には、本ポリシーに従って、本サービスをご利用いただきます。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第1条
          Text('第1条（適用）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text('1. 本ポリシーは、ユーザーと当社との間の本サービスの利用に関わる一切の関係に適用されるものとします。'),
          Text(
              '2. 当社は本サービスに関し、本ポリシーのほか、ご利用にあたってのルール等、各種の定め（以下、「個別規定」といいます。）をすることがあります。これら個別規定はその名称のいかんに関わらず、本ポリシーの一部を構成するものとします。'),
          Text(
              '3. 本ポリシーの規定が前条の個別規定の規定と矛盾する場合には、個別規定において特段の定めなき限り、個別規定の規定が優先されるものとします。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),

          //第2条
          Text('第2条（プライバシーポリシーの変更）',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              '当社は、必要と判断した場合には、ユーザーに通知することなくいつでも本ポリシーを変更することができるものとします。なお、本ポリシーの変更後、本サービスの利用を開始した場合には、当該ユーザーは変更後の規約に同意したものとみなします。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第7条
          Text('第3条（個人情報の取扱い）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text('当社は、本サービスの利用によって取得する個人情報については、当社「プライバシーポリシー」に従い適切に取り扱うものとします。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第8条
          Text('第4条（通知または連絡）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              'ユーザーと当社との間の通知または連絡は、当社の定める方法によって行うものとします。当社は,ユーザーから,当社が別途定める方式に従った変更届け出がない限り,現在登録されている連絡先が有効なものとみなして当該連絡先へ通知または連絡を行い,これらは,発信時にユーザーへ到達したものとみなします。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第9条
          Text('第5条（権利義務の譲渡の禁止）',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              'ユーザーは、当社の書面による事前の承諾なく、利用契約上の地位または本ポリシーに基づく権利もしくは義務を第三者に譲渡し、または担保に供することはできません。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第10条
          Text('第6条（準拠法・裁判管轄）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text('22. 本ポリシーの解釈にあたっては、日本法を準拠法とします。'),
          Text('23. 本サービスに関して紛争が生じた場合には、当社の本店所在地を管轄する裁判所を専属的合意管轄とします。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text('（附則）', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('2021年5月20日　制定・施行')
        ],
      ),
    );
  }
}
