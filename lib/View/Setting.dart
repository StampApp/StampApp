import 'package:flutter/material.dart';

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
        //デバック用ボタン配置
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.bug_report),
          backgroundColor: HexColor('00C2FF'),
          onPressed: () {
            print("debug!");
          },
        ),

        body: ListView(children: [
          _menuItem("利用履歴", Icon(Icons.update), _termsNavigate),
          _menuItem("使い方", Icon(Icons.phone_android)),
          _menuItem("バージョン", Icon(Icons.phonelink_setup_rounded)),
          _menuItem("利用規約", Icon(Icons.perm_device_info)),
          _menuItem(
              "プライバシーポリシー", Icon(Icons.visibility), _privacyPolicyNavigate),
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
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
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

//色をカラーコードで指定するためのクラス
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
