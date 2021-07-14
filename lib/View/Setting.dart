import 'package:flutter/material.dart';
import 'package:stamp_app/Constants/setting.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:stamp_app/models/stamp.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/enumDateType.dart';
import 'package:stamp_app/Util/enumStampCount.dart';
import 'package:stamp_app/Widget/HexColor.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void _termsNavigate() {
    Navigator.of(context).pushNamed('/terms');
  }

  void _privacyPolicyNavigate() {
    Navigator.of(context).pushNamed('/privacyPolicy');
  }

  void _historyNavigate() {
    Navigator.of(context).pushNamed('/history');
  }

  void _instructionsNavigate() {
    Navigator.of(context).pushNamed('/instructions');
  }

  Future<dynamic> _useStampCheck() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("確認"),
          content: Text("本当に利用しますか？\n使用した場合溜まっていたスタンプは消えてしまいます。"),
          actions: <Widget>[
            // ボタン領域
            OutlinedButton(
              child: const Text('cancel'),
              style: OutlinedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(color: Colors.blue),
              ),
              onPressed: () => Navigator.pop(context),
            ),

            RaisedButton(
              child: const Text('OK'),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () => {Navigator.pop(context), _useStampDialog()},
            ),
          ],
        );
      },
    );
  }

  // スタンプを使用した結果を表示
  Future<dynamic> _useStampDialog() async {
    Map res = await _useStamp();

    // スタンプが足りてない場合アラートを出して終了
    if (!res['canUseStamp']) {
      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("スタンプ利用"),
              content: Text("スタンプが溜まっていません"),
              actions: <Widget>[
                // ボタン領域
                RaisedButton(
                  child: const Text('OK'),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }

    String idsText = res['idsText'];
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("スタンプ利用"),
          content: Text("スタンプを利用しました\n\n$idsText"),
          actions: <Widget>[
            // ボタン領域
            RaisedButton(
              child: const Text('OK'),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: HexColor(Setting.APP_COLOR),
      ),
      body: ListView(children: [
        _menuItem("利用履歴", Icon(Icons.format_list_bulleted), _historyNavigate),
        _menuItem("使い方", Icon(Icons.menu_book), _instructionsNavigate),
        _menuItem("利用規約", Icon(Icons.verified_user_outlined), _termsNavigate),
        _menuItem("プライバシーポリシー", Icon(Icons.privacy_tip_outlined),
            _privacyPolicyNavigate),
        _menuItem("Version", Icon(Icons.system_update_alt_rounded)),
        _menuItem("スタンプ使用", Icon(Icons.shopping_bag_outlined), _useStampCheck),
      ]),
    );
  }

  Widget _menuItem(String title, Icon icon, [VoidCallback tap]) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(child: icon),
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ))
                      ])),
              //Versionか否か
              (title == "Version") ? _version() : Text("")
            ],
          )),
      //リストクリック時実行部分
      onTap: () {
        if (tap != null) {
          tap();
        }
      },
    );
  }
}

//version指定のwidget
Widget _version() {
  return GestureDetector(
    child: Text(
      Setting.VERSION,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 18.0,
      ),
    ),
  );
}

// スタンプ数を取得し規定数あった場合使用する
Future<Map> _useStamp() async {
  // deletedFlgがfalseのスタンプ数を取得
  int count = await DbInterface.selectStampCount('Stamp', Stamp.database);
  final int stampCheckString = StampCount.count.stampCount;

  if (count < stampCheckString) return {'idsText': null, 'canUseStamp': false};
  // deletedFlgがfalseのスタンプを取得
  List<Map<String, dynamic>> maps =
      await DbInterface.selectDeleteFlg('Stamp', Stamp.database);

  // 更新レコードを作成
  DateTime nowDate = DateTime.now();
  List<Stamp> stampList = List.generate(maps.length, (i) {
    return Stamp(
      id: maps[i]['id'],
      data: maps[i]['data'],
      getDate: formatStringToDateTime(maps[i]['getdate'], EnumDateType.date),
      getTime: formatStringToDateTime(maps[i]['gettime'], EnumDateType.time),
      stampNum: maps[i]['stampnum'],
      deletedFlg: true,
      createdAt: DateTime.parse(maps[i]['createdat']),
      deletedAt: nowDate,
    );
  });

  String idsText = '';
  // スタンプ更新
  for (var element in stampList) {
    await DbInterface.update('Stamp', Stamp.database, element);
    // 更新したIDを保持
    String id = element.id;
    idsText += '$id \n';
  }

  return {'idsText': idsText, 'canUseStamp': true};
}
