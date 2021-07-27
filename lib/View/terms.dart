import 'package:flutter/material.dart';
import 'package:stamp_app/Widget/AppBar.dart';

class TermsPage extends StatefulWidget {
  TermsPage({Key key, this.title}) : super(key: key);
  final String title;
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 25),

          Text(
              '本規約は■（以下、総称して「当社」といいます）が提供する、デジタルスタンプサービス（以下「本サービス」といいます）の利用に関する条件について、お客様と当社との間で定めるものです。必ずお読みになり、本規約の内容にご同意の上、ご利用ください。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第1条
          Text('第1条（各種規約について）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text('お客様が、本サービスをご利用いただく場合、本規約にご同意いただく必要があります。'),
          Text('（1）お客様が、本サービスをご利用いただく場合、当社が定める、「利用規約」が適用されます。必ずご確認ください。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第2条
          Text('第2条（定義）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text('本規約において使用する用語の定義は、次の各号に定めるとおりとします。'),
          Text(
              '（1）本サービスとは、stamp_appを通じて提供する「スタンプサービス加盟企業のスタンプカード」（以下「スタンプカード」といいます）に、その他当社が定めた条件に応じてデジタルスタンプを付与するサービスのことをいいます。'),
          Text('（2）「利用者」とは、本サービスを利用される方をいいます。'),
          Text('（3）「スタンプサービス加盟企業」とは、本サービスを利用してスタンプサービスを提供する企業のことをいいます。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第3条
          Text('第3条（本サービス）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              '本規約にご同意いただきますと、以下で定める機能等のstamp_appを通じてスタンプカードをご利用いただけるようになります。ただし、システム上の理由から、当該アプリに表示される本サービスに関する情報が、スタンプサービス加盟企業に関する最新の情報を反映していない場合があります。また、本サービスの内容は、事前の通知なく、変更されることがあります。あらかじめご了承ください。'),
          Text('（1）スタンプサービス加盟企業での本サービスの利用'),
          Text('（2）以下に記載するスタンプカードに関する情報の照会及び確認'),
          Text('・スタンプ数'),
          Text('・スタンプ履歴'),
          Text('（3）その他前各号に関連するサービス'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第4条
          Text('第4条（スタンプの付与）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              '本サービスのスタンプの付与に関する条件は、stamp_app上のスタンプカード内(以下「本ページ」といいます)に掲載しております。本ページは本規約の一部を構成するものとします。'),
          Text('スタンプカードを異なる携帯端末に保有していた場合、それぞれに貯めているスタンプ数を合算することはできません。'),
          Text('スタンプカードをお忘れの際は、スタンプを付与できませんので、ご注意ください。'),
          Text(
              'お客様のインターネットの通信環境や、携帯端末の不具合・故障等により各企業別スタンプカードが表示できない等のエラーが生じた場合は、スタンプを付与することはできません。当社は、これによって利用者に生じたいかなる損害についても一切の責任を負いません。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第5条
          Text('第5条（スタンプの利用）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              'スタンプは貯まったその日に利用することができます。貯まったスタンプは、当社が事前に告知した条件に従い、指定の商品やサービス等の特典との交換に利用することができます。'),
          Text(
              'スタンプの利用後に、お客様が本規約またはその他規約に違反していることが判明した場合など、当社が付与したスタンプを次条に基づき取消したときは、お客様はすみやかに特典を返還するものとします。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第6条
          Text('第6条（スタンプの取消し等）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              '当社は、利用者が以下各号に該当する場合、お客様に付与したスタンプを取消し、デジタルスタンプサービスの全部または一部の提供または利用を停止することができます。'),
          Text('（1）スタンプを付与した後に当該付与にかかる取引の解除、取消しが発生した場合'),
          Text('（2）本規約、その他規約に違反する行為があった場合、またはそのおそれがある場合'),
          Text('（3）違法または不正な行為があった場合'),
          Text('（4）その他、当社が付与したスタンプを取消すことが適当と判断した場合'),
          Text(
              '当社は、スタンプの交換対象のサービスや特典が利用できないことが判明した場合、デジタルスタンプサービスの全部または一部の提供および利用を停止することができます。当社は、第1項各項によってお客様に生じたいかなる損害についても一切の責任を負いません。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第7条
          Text('第7条（有効期限）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text('貯まったスタンプの有効期限はスタンプカード上に定められています。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第8条
          Text('第8条（本サービスの変更・中断・終了）',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              '当社は、事業上の理由、システムの過負荷・システムの不具合・メンテナンス・法令の制定改廃・天災地変・偶発的事故・停電・通信障害・不正アクセス、その他の事由により、本サービスをいつでも変更、中断、終了することができるものとし、これによってお客様に生じたいかなる損害についても一切の責任を負いません。なお、本サービスを全て廃止する場合においては、当社は、事前にお客様にその旨を通知するものとします。'),
          Text(
              '当社は、前項の変更、中断、終了にあたっては、事前に相当期間をもって予告するよう努めます。ただし、緊急やむをえない場合は、この限りではありません。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第9条
          Text('第9条（注意事項）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              'スタンプカードを所定の手続きに従い削除した場合、stamp_appを通じてスタンプカードをご利用いただくことができなくなります。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第10条
          Text('第10条（禁止行為）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text('お客様は、本サービスの利用にあたり、以下の各号に該当し、または該当すると当社が判断する行為をしてはなりません。'),
          Text('（1）本サービスの運営を妨げる行為、誹謗する行為'),
          Text('（2）本サービスを利用した公序良俗に反する行為、犯罪行為'),
          Text('（3）その他規約に定める禁止行為'),
          Text('（4）その他、当社が不適切と判断する行為'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第11条
          Text('第11条（規約の変更）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text('当社は、一定の予告期間をおいて変更後の本規約の内容を周知することにより、本規約の内容を変更することができるものとします。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第12条
          Text('第12条（免責）', style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(
              '当社は、本サービスの提供に際して、自己の故意または重過失によりお客様に損害を与えた場合についてのみこれを賠償するものとします。本規約における当社の各免責規定は、当社に故意または重過失が存する場合には適用しません。'),
          Text(
              '当社がお客様に対して損害賠償義務を負う場合、賠償すべき損害の範囲は、利用者に現実に発生した通常の損害に限る（逸失利益を含む特別の損害は含まない）ものとします。'),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //附則
          Text('（附則）', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('2021年5月13日　制定・施行')
        ],
      ),
    );
  }
}
