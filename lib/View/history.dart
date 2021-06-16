import 'package:flutter/material.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/enumDateType.dart';
import 'package:stamp_app/models/stamp.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key, this.title}) : super(key: key);
  final String title;

  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<DropdownMenuItem<int>> _items = List();
  int _selectItem = 0;
  List<String> dateList = [];
  List<Stamp> stampList = [];
  int pastMonth = 3;

  // DBから使用したスタンプを取得する
  getStampList() async {
    List<Map<String, dynamic>> maps = 
      await DbInterface.selectDateDesc('Stamp', Stamp.database, DateTime.now(), pastMonth);

    // mapからstamp型への変換
    return List.generate(maps.length, (i) {
      return Stamp(
        id: maps[i]['id'],
        data: maps[i]['data'],
        getDate: dateFormatParse(maps[i]['getdate'], enumDateType.date.toString()),
        getTime: dateFormatParse(maps[i]['gettime'], enumDateType.time.toString()),
        deletedFlg: maps[i]['deletedflg'] == 0,
      );
    });
  }

  // 重複しないDateをsatmpListから取得する
  getDateList() async {
    stampList = await getStampList();
    for (int i = 0; i < stampList.length; i++) {
      var getDate = toDateOrTime(stampList[i].getDate, enumDateType.date.toString());
      if (dateList.length == 0) {
        dateList.add(getDate);
        // datelistの最後尾と一致しない場合
      } else if (getDate != dateList.last) {
        dateList.add(getDate);
      }
    }
    return dateList;
  }

  // 取得するスタンプの日付条件を変更する
  pastMonthChange(int dropDownValue) {
    List pastMonthArr = [3, 6, 9, 12];
    pastMonth = pastMonthArr[dropDownValue];
  }

  @override
  void initState() {
    super.initState();
    setItem();
    _selectItem = _items[0].value;
  }

  //ドロップダウンの中身のアイテム
  void setItem() {
    List<Map> dropdownItem = [
      {'text': '過去3ヶ月', 'value': 0},
      {'text': '過去6ヶ月', 'value': 1},
      {'text': '過去9ヶ月', 'value': 2},
      {'text': '過去12ヶ月', 'value': 3},
    ];
    _items = 
    dropdownItem.map<DropdownMenuItem<int>>((Map maps) {
      return DropdownMenuItem<int>(
        value: maps['value'],
        child: Text(
          maps['text'],
          style: TextStyle(fontSize: 20.0),
        ),
      );
    }).toList();
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

            // リストの日付の処理が終わるまで読み込み中を表示する
            body: FutureBuilder(
              future: getDateList(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data != null) {
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
                                pastMonthChange(value),
                                dateList = [],
                                setState(() => _selectItem = value),
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
            )));
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
                //trueならスタンプ使用、それ以外ならスタンプゲットwidget呼び出し
                (stamplist.deletedFlg == true) ? _usestamp() : _getstamp(),
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
