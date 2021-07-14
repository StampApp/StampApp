import 'package:flutter/material.dart';
import 'package:stamp_app/Constants/setting.dart';
import 'package:stamp_app/Widget/stamp_icon_icons.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/enumDateType.dart';
import 'package:stamp_app/models/stamp.dart';
import 'package:stamp_app/Widget/HexColor.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key, this.title}) : super(key: key);
  final String title;

  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<DropdownMenuItem<int>> _items = [];
  int _selectItem = 0;
  List<Stamp> stampList = [];
  int pastMonth = 3;

  // DBから使用したスタンプを取得する
  getStampList() async {
    List<Map<String, dynamic>> maps = await DbInterface.selectDateDesc(
        'Stamp', Stamp.database, DateTime.now(), pastMonth);

    // mapからstamp型への変換
    return List.generate(maps.length, (i) {
      return Stamp(
        id: maps[i]['id'],
        data: maps[i]['data'],
        getDate: formatStringToDateTime(maps[i]['getdate'], EnumDateType.date),
        getTime: formatStringToDateTime(maps[i]['gettime'], EnumDateType.time),
        deletedFlg: maps[i]['deletedflg'] == 0,
      );
    });
  }

  // 重複しないDateをsatmpListから取得する
  getDateList() async {
    List dateList = [];
    stampList = await getStampList();
    for (int i = 0; i < stampList.length; i++) {
      var getDate =
          formatDateTimeToString(stampList[i].getDate, EnumDateType.date);
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
    _items = dropdownItem.map<DropdownMenuItem<int>>((Map maps) {
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
    final Size displaySize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: HexColor(Setting.APP_COLOR),
        ),

        // リストの日付の処理が終わるまで読み込み中を表示する
        body: FutureBuilder(
          future: getDateList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // getDateListの処理が終了した場合
            if (snapshot.connectionState == ConnectionState.done) {
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
                              color: HexColor(Setting.APP_COLOR), width: 1),
                        ),
                        child: DropdownButton(
                          items: _items,
                          value: _selectItem,
                          onChanged: (value) => {
                            pastMonthChange(value),
                            setState(() => _selectItem = value),
                          },
                        ),
                      )
                    ]),
                if (snapshot.data.length != 0)
                  for (int i = 0; i < snapshot.data.length; i++)
                    _line(snapshot.data[i], stampList)
                // データが存在しなかった場合
                else
                  Container(
                    alignment: Alignment.center,
                    height: displaySize.height * 0.6,
                    child: Text("利用履歴がありません", style: TextStyle(fontSize: 20.0)),
                  )
              ]);
            } else {
              return Container(
                alignment: Alignment.center,
                height: displaySize.height,
                child: Text("読み込み中", style: TextStyle(fontSize: 20.0)),
              );
            }
          },
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
                          if (formatDateTimeToString(
                                  stamp.getDate, EnumDateType.date) ==
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
                (stamplist.deletedFlg) ? _usestamp() : _getstamp(),
                Container(
                    child: Text(formatDateTimeToString(
                        stamplist.getTime, EnumDateType.time)))
              ])));
}

//スタンプ使用時
Widget _usestamp() {
  return GestureDetector(
      child: Row(children: <Widget>[
    Icon(Icons.autorenew),
    Container(
        margin: const EdgeInsets.only(left: 10),
        child: Text(
          "利用",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ))
  ]));
}

//スタンプ取得
Widget _getstamp() {
  return GestureDetector(
      child: Row(children: <Widget>[
    Icon(StampIcon.stamp),
    Container(
        margin: const EdgeInsets.only(left: 10),
        child: Text(
          "スタンプゲット",
          style: TextStyle(
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
        tileColor: HexColor(Setting.APP_COLOR),
      ),
    ),
  );
}
