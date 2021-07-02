import 'package:flutter/material.dart';
import 'package:stamp_app/Widget/HexColor.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:stamp_app/models/stamp.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/enumDateType.dart';

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
          content: Text("本当に使用しますか？\n使用した場合溜まっていたスタンプは消えてしまいます。"),
          actions: <Widget>[
            // ボタン領域
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () => _useStamp(context),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _useStamp(context) async {
    // deletedFlgがfalseのスタンプ数を取得
    int count = await DbInterface.selectStampCount('Stamp', Stamp.database);

    // スタンプが足りてない場合アラートを出して終了
    if (count < 9) {
      Navigator.pop(context);
      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("完了"),
              content: Text("スタンプが溜まっていません"),
              actions: <Widget>[
                // ボタン領域
                TextButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }
    // deletedFlgがfalseのスタンプを取得
    List<Map<String, dynamic>> maps =
        await DbInterface.selectDeleteFlg('Stamp', Stamp.database);

    // 更新レコードを作成
    DateTime nowDate = DateTime.now();
    List<Stamp> stampList = List.generate(maps.length, (i) {
      return Stamp(
        id: maps[i]['id'],
        data: maps[i]['data'],
        getDate:
            dateFormatParse(maps[i]['getdate'], enumDateType.date.toString()),
        getTime:
            dateFormatParse(maps[i]['gettime'], enumDateType.time.toString()),
        stampNum: maps[i]['stampnum'],
        deletedFlg: true,
        createdAt: nowDate,
        deletedAt: DateTime.parse(maps[i]['deletedat']),
      );
    });

    String idsText = '';
    // スタンプ更新
    for (var element in stampList) {
      await DbInterface.update('Stamp', Stamp.database, element);
      String id = element.id;
      idsText += '$id \n';
    }

    Navigator.pop(context);
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("完了"),
          content: Text("スタンプを利用しました\n\n$idsText"),
          actions: <Widget>[
            // ボタン領域
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: HexColor('00C2FF'),
        ),
        body: ListView(children: [
          _menuItem("利用履歴", Icon(Icons.update), _historyNavigate),
          _menuItem("使い方", Icon(Icons.phone_android), _instructionsNavigate),
          _menuItem(
              "利用規約", Icon(Icons.phonelink_setup_rounded), _termsNavigate),
          _menuItem(
              "プライバシーポリシー", Icon(Icons.visibility), _privacyPolicyNavigate),
          _menuItem("Version", Icon(Icons.visibility)),
          _menuItem(
              "スタンプ使用", Icon(Icons.shopping_bag_outlined), _useStampCheck),
        ]),
      ),
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
      "0.1.0",
      style: TextStyle(
        color: Colors.grey,
        fontSize: 18.0,
      ),
    ),
  );
}
