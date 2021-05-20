import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key, this.title}) : super(key: key);
  final String title;

  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

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
          _menuItem("スタンプ取得", Icon(Icons.update)),
          _menuItem("交換", Icon(Icons.phone_android)),
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
