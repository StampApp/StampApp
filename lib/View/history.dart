import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key, this.title}) : super(key: key);
  final String title;

  _HistoryPageState createState() => _HistoryPageState();
}

//スタンプクラス
class Stamp {
  int id;
  String date;
  String time;
  int flag;
  Stamp(this.id, this.date, this.time, this.flag);
}

//スタンプ使用か判断するために使用
final int UseFlag = 1;

class _HistoryPageState extends State<HistoryPage> {
  List<DropdownMenuItem<int>> _items = List();
  int _selectItem = 0;

  // 画面に表示するリストを定義
  final List<Stamp> stampList = [
    new Stamp(1, "2021/5/25", "10時30分", 1),
    new Stamp(2, "2021/5/25", "12時20分", 1),
    new Stamp(3, "2021/5/30", "14時50分", 1),
    new Stamp(4, "2021/5/30", "11時00分", 0),
    new Stamp(4, "2021/5/30", "11時00分", 1),
    new Stamp(4, "2021/5/31", "14時00分", 0),
    new Stamp(4, "2021/5/31", "17時00分", 1),
    new Stamp(4, "2021/5/31", "17時00分", 1),
  ];

  //DateList初期化
  List<String> dateList = [];

  //重複しないDateをsatmpListから取得する
  void getDateList(List<Stamp> list) {
    int j = 0;
    for (int i = 0; i < list.length; i++) {
      if (i == 0) {
        dateList.add(list[i].date);
      } else if (list[i].date != dateList[j]) {
        dateList.add(stampList[i].date);
        j++;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setItem();
    _selectItem = _items[0].value;
  }

  //ドロップダウンの中身のアイテム
  void setItem() {
    _items
      ..add(DropdownMenuItem(
        child: Text(
          '利用時期',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 0,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '過去3ヶ月',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 1,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '過去6ヶ月',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 2,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '過去9ヶ月',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 3,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '過去12ヶ月',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 4,
      ));
  }

  @override
  Widget build(BuildContext context) {
    //Dateリスト作成
    getDateList(stampList);
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
            body: ListView(children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                //ドロップダウンメニュー
                Container(
                  padding: EdgeInsets.only(left: 15),
                  margin: EdgeInsets.only(top: 16.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    //枠線を丸くするかどうか
                    //borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: HexColor('00C2FF'), width: 1),
                  ),
                  child: DropdownButton(
                    items: _items,
                    value: _selectItem,
                    onChanged: (value) => {
                      setState(() {
                        _selectItem = value;
                      }),
                    },
                  ),
                )
              ]),
              for (int i = 0; i < dateList.length; i++)
                _line(dateList[i], stampList)
            ])));
  }
}

Widget _line(String targetDate, List<Stamp> stampList) {
  return GestureDetector(
      child: Column(
    children: <Widget>[
      // 日付表示
      _delimiter(targetDate),
      ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: stampList
                    .map((Stamp stamp) => Column(children: <Widget>[
                          if (stamp.date == targetDate) _row(stamp)
                        ]))
                    .toList())
          ]),
    ],
  ));
}

//List1行表示
Widget _row(Stamp stamplist) {
  return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //flagがUseFlagならスタンプ使用、それ以外ならスタンプゲットwidget呼び出し
                (stamplist.flag == UseFlag) ? _usestamp() : _getstamp(),
                Container(child: Text(stamplist.time))
              ])));
}

//スタンプ使用時
Widget _usestamp() {
  return GestureDetector(
      child: Row(children: <Widget>[
    Icon(Icons.android),
    Container(
        margin: const EdgeInsets.only(left: 10),
        child: Text(
          "消費",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ))
  ]));
}

//スタンプ取得
Widget _getstamp() {
  return GestureDetector(
      child: Row(children: <Widget>[
    Icon(Icons.ac_unit_sharp),
    Container(
        margin: const EdgeInsets.only(left: 10),
        child: Text(
          "スタンプゲット",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ))
  ]));
}

//日付の一行
Widget _delimiter(String date) {
  //年月日、色コード
  return GestureDetector(
    child: Container(
      child: ListTile(
        title: Text(
          //スタンプ取得、交換日を受け取る
          date,
          style: TextStyle(fontSize: 20),
        ),
        tileColor: HexColor("00C2FF"),
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
