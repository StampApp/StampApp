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
          Text('第2条（禁止事項）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text('ユーザーは、本サービスの利用にあたり、以下の行為をしてはなりません。'),
          Text('4. 法令または公序良俗に違反する行為'),
          Text('5. 犯罪行為に関連する行為'),
          Text('6.当社、本サービスの他のユーザー、または第三者のサーバーまたはネットワークの機能を破壊したり、妨害したりする行為'),
          Text('7.当社のサービスの運営を妨害するおそれのある行為'),
          Text('8. 他のユーザーに関する個人情報等を収集または蓄積する行為'),
          Text('9. 不正アクセスをし、またはこれを試みる行為'),
          Text('10. 他のユーザーに成りすます行為'),
          Text('11. 当社のサービスに関連して、反社会的勢力に対して直接または間接に利益を供与する行為'),
          Text(
              '12. 当社、本サービスの他のユーザーまたは第三者の知的財産権、肖像権、プライバシー、名誉その他の権利または利益を侵害する行為'),
          Text('13. 以下を目的とし、または目的とすると当社が判断する行為'),
          Text('a. 営業、宣伝、広告、勧誘、その他営利を目的とする行為（当社の認めたものを除きます。）'),
          Text('b. 性行為やわいせつな行為を目的とする行為'),
          Text('c. 面識のない異性との出会いや交際を目的とする行為'),
          Text('d. 他のユーザーに対する嫌がらせや誹謗中傷を目的とする行為'),
          Text('e. 当社、本サービスの他のユーザー、または第三者に不利益、損害または不快感を与えることを目的とする行為'),
          Text('f. その他本サービスが予定している利用目的と異なる目的で本サービスを利用する行為'),
          Text('14. 宗教活動または宗教団体への勧誘行為'),
          Text('15. その他、当社が不適切と判断する行為'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第3条
          Text('第3条（本サービスの提供の停止等）',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              '16. 当社は、以下のいずれかの事由があると判断した場合、ユーザーに事前に通知することなく本サービスの全部または一部の提供を停止または中断することができるものとします。'),
          Text('a. 本サービスにかかるコンピュータシステムの保守点検または更新を行う場合'),
          Text('b. 地震、落雷、火災、停電または天災などの不可抗力により、本サービスの提供が困難となった場合'),
          Text('c. コンピュータまたは通信回線等が事故により停止した場合'),
          Text('d. その他、当社が本サービスの提供が困難と判断した場合'),
          Text(
              '17. 当社は、本サービスの提供の停止または中断により、ユーザーまたは第三者が被ったいかなる不利益または損害についても、一切の責任を負わないものとします。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第4条
          Text('第4条（保証の否認および免責事項）',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              '18. 当社は、本サービスに事実上または法律上の瑕疵（安全性、信頼性、正確性、完全性、有効性、特定の目的への適合性、セキュリティなどに関する欠陥、エラーやバグ、権利侵害などを含みます。）がないことを明示的にも黙示的にも保証しておりません。'),
          Text(
              '19. 当社は、本サービスに起因してユーザーに生じたあらゆる損害について一切の責任を負いません。ただし、本サービスに関する当社とユーザーとの間の契約（本ポリシーを含みます。）が消費者契約法に定める消費者契約となる場合、この免責規定は適用されません。'),
          Text(
              '20. 前項ただし書に定める場合であっても、当社は、当社の過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害のうち特別な事情から生じた損害（当社またはユーザーが損害発生につき予見し、または予見し得た場合を含みます。）について一切の責任を負いません。また、当社の過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害の賠償は、ユーザーから当該損害が発生した月に受領した利用料の額を上限とします。'),
          Text(
              '21. 当社は、本サービスに関して、ユーザーと他のユーザーまたは第三者との間において生じた取引、連絡または紛争等について一切責任を負いません。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第5条
          Text('第5条（サービス内容の変更等）',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              '当社は、ユーザーに通知することなく、本サービスの内容を変更しまたは本サービスの提供を中止することができるものとし、これによってユーザーに生じた損害について一切の責任を負いません。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第6条
          Text('第6条（プライバシーポリシーの変更）',
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
          Text('第7条（プライバシーポリシーの変更）',
              style: TextStyle(fontWeight: FontWeight.bold)),
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
          Text('第8条（通知または連絡）', style: TextStyle(fontWeight: FontWeight.bold)),
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
          Text('第9条（権利義務の譲渡の禁止）',
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
          Text('第10条（準拠法・裁判管轄）', style: TextStyle(fontWeight: FontWeight.bold)),
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
        ],
      ),
    );
  }
}
