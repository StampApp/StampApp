import 'package:flutter/material.dart';
import 'package:stamp_app/Constants/setting.dart';
import 'package:stamp_app/Util/toInt.dart';
import 'package:stamp_app/Widget/stamp_icon_icons.dart';
import 'package:stamp_app/dbHelper.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/Enums/enumDateType.dart';
import 'package:stamp_app/Widget/HexColor.dart';
import 'package:stamp_app/Widget/AppBar.dart';
import 'package:stamp_app/models/stampLogs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key, required this.title}) : super(key: key);
  final String title;

  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<DropdownMenuItem<int>> _items = [];
  int _selectItem = 0;
  List<StampLogs> stampList = [];
  int pastMonth = 3;
  String? _noHistory;
  String? _loading;
  String? _getStamp;
  String? _useStamp;

  getStampList() async {
    List maps = await DbInterface.selectDateDescLogs(
        'StampLogs', DBHelper.databese(), DateTime.now(), pastMonth);

    // mapからstamp型への変換
    return List.generate(maps.length, (i) {
      return StampLogs(
        id: maps[i]['id'],
        stampId: maps[i]['stamp_id'],
        getDate:
            formatStringToDateTime(maps[i]['stamp_date'], EnumDateType.date),
        getTime:
            formatStringToDateTime(maps[i]['stamp_time'], EnumDateType.time),
        useFlg: parseIntToBoolean(maps[i]['useflg']),
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

  //利用履歴の削除を行い画面を再表示する
  deleteLogs() {
    setState(() {});
    DbInterface.allDelete('StampLogs', DBHelper.databese());
  }

  void init() {
    setItem();
    _selectItem = _items[0].value!;
    _noHistory = AppLocalizations.of(context)!.noUsageHistory;
    _loading = AppLocalizations.of(context)!.loading;
    _getStamp = AppLocalizations.of(context)!.gettingStamp;
    _useStamp = AppLocalizations.of(context)!.useStamp;
  }

  //ドロップダウンの中身のアイテム
  void setItem() {
    List<Map> dropdownItem = [
      {'text': AppLocalizations.of(context)!.last3Months, 'value': 0},
      {'text': AppLocalizations.of(context)!.last6Months, 'value': 1},
      {'text': AppLocalizations.of(context)!.last9Months, 'value': 2},
      {'text': AppLocalizations.of(context)!.last12Months, 'value': 3},
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
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(deviceHeight * 0.08),
        child: AppBarPage(widget.title),
      ),

      // リストの日付の処理が終わるまで読み込み中を表示する
      body: FutureBuilder(
        future: getDateList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          init();
          // getDateListの処理が終了した場合
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextButton(
                        child:
                            Text(AppLocalizations.of(context)!.deleteHistory),
                        style: OutlinedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(color: HexColor(Setting.APP_COLOR)),
                        ),
                        onPressed: () => _deleteLogsCheck(),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
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
                              pastMonthChange(value as int),
                              setState(() => _selectItem = value),
                            },
                          ),
                        )),
                    //ドロップダウンメニュー
                  ]),
              if (snapshot.data.length != 0)
                for (int i = 0; i < snapshot.data.length; i++)
                  _line(snapshot.data[i], stampList)
              // データが存在しなかった場合
              else
                Container(
                  alignment: Alignment.center,
                  height: displaySize.height * 0.6,
                  child: Text(_noHistory!, style: TextStyle(fontSize: 20.0)),
                )
            ]);
          } else {
            return Container(
              alignment: Alignment.center,
              height: displaySize.height,
              child: Text(_loading!, style: TextStyle(fontSize: 20.0)),
            );
          }
        },
      ),
    );
  }

  Widget _line(String targetDate, List<StampLogs> stampList) {
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
                      .map((StampLogs stamp) => Column(children: <Widget>[
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
  Widget _row(StampLogs stamplist) {
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            decoration: new BoxDecoration(
                border: new Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //trueならスタンプ使用、それ以外ならスタンプゲットwidget呼び出し
                  (stamplist.useFlg) ? _usestamp() : _getstamp(),
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
            _useStamp!,
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
            _getStamp!,
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

  //履歴削除の確認ダイアログ
  Future<dynamic> _deleteLogsCheck() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(10, 30, 10, 30),
          title: Text(AppLocalizations.of(context)!.confirmation),
          content: Text(AppLocalizations.of(context)!.reallyDeleteHistory),
          actions: <Widget>[
            // ボタン領域
            OutlinedButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              style: OutlinedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(color: Colors.blue),
              ),
              onPressed: () => Navigator.pop(context),
            ),

            ElevatedButton(
              child: Text(AppLocalizations.of(context)!.ok),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => {Navigator.pop(context), deleteLogs()},
            ),
          ],
        );
      },
    );
  }
}
