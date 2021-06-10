import 'package:flutter/material.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/enumDateType.dart';
import 'package:stamp_app/models/stamp.dart';
import "package:intl/intl.dart";

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key, this.title}) : super(key: key);
  final String title;

  _HistoryPageState createState() => _HistoryPageState();
}

//スタンプ使用か判断するために使用
final bool useFlag = true;

class _HistoryPageState extends State<HistoryPage> {
  List<DropdownMenuItem<int>> _items = List();
  int _selectItem = 0;

  getStampList() async {
    List<Map<String, dynamic>> maps =
        await DbInterface.allSelect('Stamp', Stamp.database);

    return List.generate(maps.length, (i) {
      final dateFormatter = DateFormat("y/M/d");
      final timeFormatter = DateFormat("HH:mm:ss");
      return Stamp(
        id: maps[i]['id'],
        data: maps[i]['data'],
        getDate: dateFormatter.parseStrict(maps[i]['getdate']),
        getTime: timeFormatter.parseStrict(maps[i]['gettime']),
      );
    });
  }

  //DateList初期化
  List<String> dateList = [];
  List<Stamp> stampList = [];

  //重複しないDateをsatmpListから取得する
  getDateList() async {
    stampList = await getStampList();
    int j = 0;
    for (int i = 0; i < stampList.length; i++) {
      var getDate =
          toDateOrTime(stampList[i].getDate, enumDateType.date.toString());
      if (i == 0) {
        dateList.add(getDate);
      } else if (getDate != dateList[j]) {
        dateList.add(getDate);
        j++;
      }
    }
    return dateList;
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
            body: FutureBuilder(
              future: getDateList(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView(children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          //ドロップダウンメニュー
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            margin: EdgeInsets.only(top: 16.0, bottom: 10.0),
                            decoration: BoxDecoration(
                              //枠線を丸くするかどうか
                              //borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: HexColor('00C2FF'), width: 1),
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
                  ]);
                } else {
                  return Text("読み込み中");
                }
              },
            )
            // body: ListView(children: <Widget>[
            //   Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            //     //ドロップダウンメニュー
            //     Container(
            //       padding: EdgeInsets.only(left: 15),
            //       margin: EdgeInsets.only(top: 16.0, bottom: 10.0),
            //       decoration: BoxDecoration(
            //         //枠線を丸くするかどうか
            //         //borderRadius: BorderRadius.circular(10.0),
            //         border: Border.all(color: HexColor('00C2FF'), width: 1),
            //       ),
            //       child: DropdownButton(
            //         items: _items,
            //         value: _selectItem,
            //         onChanged: (value) => {
            //           setState(() {
            //             _selectItem = value;
            //           }),
            //         },
            //       ),
            //     )
            //   ]),
            //   for (int i = 0; i < dateList.length; i++)
            //     _line(dateList[i], stampList)
            // ])
            ));
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
                          if (toDateOrTime(stamp.getDate,
                                  enumDateType.date.toString()) ==
                              targetDate)
                            _row(stamp)
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
                //flagがuseFlagならスタンプ使用、それ以外ならスタンプゲットwidget呼び出し
                (stamplist.deletedFlg == useFlag) ? _usestamp() : _getstamp(),
                Container(
                    child: Text(toDateOrTime(
                        stamplist.getTime, enumDateType.time.toString())))
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
          "利用",
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
