import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stamp_app/models/stamp.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:stamp_app/Widget/qrScan.dart';
import 'package:stamp_app/models/memo.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:uuid/uuid.dart';
import '../Widget/stampDialog.dart';
import '../Widget/stampMaxDialog.dart';
import '../checkIsMaxStamps.dart';
import 'package:flutter/material.dart';

import 'package:page_indicator/page_indicator.dart';

import 'package:page_view_indicators/circle_page_indicator.dart';

class HomeSamplePage extends StatefulWidget {
  HomeSamplePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeSamplePageState createState() => _HomeSamplePageState();
}

// カラーコードをHexColorでできるように
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

class _HomeSamplePageState extends State<HomeSamplePage> {
  static final uuid = Uuid();
  static final DateTime dateTime = DateTime.now();

  //カード枚数は1以上
  int cardnum = 1;

  //スタンプ合計
  int stampsum = 0;

  //カード枚数格納配列
  List<String> cardnumber = [];

  List<List<Stamp>> cardList = [];

  //pageviewで使用
  PageController controller;
  PageController _pageController;
  int _currentPage = 0;

  final List<Stamp> stampList = [
    new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '1',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    ),
    new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '2',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    ),
    new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '3',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    ),
    new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '4',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    ),
    new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '5',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    ),
    new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '6',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    ),
    new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '7',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    ),
    new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '8',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    ),
    new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '9',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    ),
    new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '10',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    ),
    new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '11',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    )
  ];

  static final String stampCheckString = "ok";

  void _settingNavigate() {
    Navigator.of(context).pushNamed('/Setting');
  }

  void _crudSample() async {
    final DateTime dateTime = DateTime.now();
    final update = new Stamp(
      id: '4eef4900-c340-11eb-80aa-4babbebbda13',
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '10',
      deletedFlg: true,
      createdAt: dateTime,
      deletedAt: dateTime,
    );

    /*
    await DbInterface.insert('Stamp', Stamp.database, stampList[0]);

    print(await DbInterface.select('Stamp', Stamp.database, 0));

    await DbInterface.insert('Stamp', Stamp.database, stampList[1]);
*/
    await DbInterface.update('Stamp', Stamp.database, update);

    print(await DbInterface.allSelect('Stamp', Stamp.database));
/*
    await DbInterface.delete('Stamp', Stamp.database, 0);
    */
  }

  void _demoCRUD() async {
    var memo = Memo(
      id: uuid.v1(),
      text: 'Flutterで遊ぶ',
      priority: 1,
    );

    await DbInterface.insert('memo', Memo.database, memo);

    print(await DbInterface.select('memo', Memo.database, memo.id));

    memo = Memo(
      id: uuid.v1(),
      text: memo.text,
      priority: memo.priority + 1,
    );

    await DbInterface.insert('memo', Memo.database, memo);

    print(await DbInterface.select('memo', Memo.database, memo.id));

    await DbInterface.delete('memo', Memo.database, memo.id);

    print(await DbInterface.allSelect('memo', Memo.database));
  }

  Future<void> _qrScan() async {
    ScanResult result = await qrScan();
    final DateTime dateTime = DateTime.now();

    if (result.format.name == "qr") {
      int maxStamp = 9; //上限無しの場合0を指定
      int stampListLen = stampList.length;
      int crossAxisCount = 3;
      int successStampLen =
          stampList.where((element) => element.data == stampCheckString).length;

      if (checkIsMaxStamps(successStampLen, maxStamp)) {
        if (successStampLen >= maxStamp) {
          stampMaxDialogAlert(context, maxStamp);
        } else {
          Stamp newStamp = new Stamp(
              id: uuid.v1(),
              data: "ok",
              getDate: dateTime,
              getTime: dateTime,
              stampNum: (successStampLen + 1).toString(),
              deletedFlg: true,
              createdAt: dateTime,
              deletedAt: dateTime);
          setState(() {
            stampList[successStampLen] = newStamp;
          });
          stampMaxDialogAlert(context, maxStamp);
        }
      } else {
        if (stampListLen == successStampLen + 1) {
          for (int i = stampListLen; i < stampListLen + crossAxisCount; i++) {
            Stamp newStamp = new Stamp(
                id: uuid.v1(),
                data: "",
                getDate: dateTime,
                getTime: dateTime,
                stampNum: (i + 1).toString(),
                deletedFlg: true,
                createdAt: dateTime,
                deletedAt: dateTime);
            stampList.add(newStamp);
          }
        }
        Stamp newStamp = new Stamp(
            id: uuid.v1(),
            data: "ok",
            getDate: dateTime,
            getTime: dateTime,
            stampNum: (successStampLen + 1).toString(),
            deletedFlg: true,
            createdAt: dateTime,
            deletedAt: dateTime);
        setState(() {
          stampList[successStampLen] = newStamp;
        });
      }
    }
  }

  @override
  void initState() {
    //アプリ起動時に一度だけ実行、スタンプテーブルの個数を3の倍数にする

    int stampListLen = stampList.length;

    //GridViewのcrossAxisCountの値
    int crossAxisCount = 3;
    int listRow = 3;
    //int listRow = stampListLen ~/ crossAxisCount + 1;
    //crossAxisCount < listRow ? null : listRow = 3;

    //スタンプが1個以上あるなら必要なカードを求める
    if (stampListLen != 0) {
      cardnum = (stampListLen / 9).ceil();
    }

    //StampListからStampを9個ずつ配列に格納する
    int num = 0;

    for (int j = 0; j < cardnum; j++) {
      List<Stamp> cardStamp = [];
      for (int i = num; i < num + 9 && i != stampListLen; i++) {
        Stamp sp = stampList[i];
        cardStamp.add(sp);
      }
      //一つのカードにStampが9個未満の場合
      if (cardStamp.length != 9) {
        Stamp lastStamp = cardStamp.last;
        String stampnumber = lastStamp.stampNum;
        int number = int.parse(stampnumber);

        while (cardStamp.length < 9) {
          number++;
          //一つのカードの中身を9個埋めるために空のStampデータ代入
          Stamp noStamp = new Stamp(
            id: uuid.v1(),
            data: "no",
            getDate: dateTime,
            getTime: dateTime,
            stampNum: number.toString(),
            deletedFlg: true,
            createdAt: dateTime,
            deletedAt: dateTime,
          );
          cardStamp.add(noStamp);
        }
      }

      cardnumber.add(j.toString());
      cardList.add(cardStamp);

      num = num + 9;
    }

    for (int i = stampListLen + 1; i <= listRow * crossAxisCount; i++) {
      Stamp newStamp = new Stamp(
          id: uuid.v1(),
          data: "",
          getDate: dateTime,
          getTime: dateTime,
          stampNum: (i).toString(),
          deletedFlg: true,
          createdAt: dateTime,
          deletedAt: dateTime);
      stampList.add(newStamp);
    }

    //Pageviewのため-------------------------------
    super.initState();

    controller = PageController();
    _pageController = PageController();
    _pageController.addListener(() {
      final nextPage = _pageController.page.round();
      if (_currentPage != nextPage) {
        _currentPage = nextPage;
      }
    });
    //-------------------------------------
  }

  //pageviewで使用

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffoldは画面構成の基本Widget
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          // 設定ボタン
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white, size: 38),
            onPressed: _settingNavigate,
          ),
        ],
        backgroundColor: HexColor('00C2FF'),
      ),
      // QRへ遷移
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'QR',
          style: TextStyle(
            fontSize: 24.0,
            fontStyle: FontStyle.normal,
            letterSpacing: 4.0,
          ),
        ),
        icon: Icon(Icons.qr_code),
        onPressed: _qrScan,
        backgroundColor: HexColor('00C2FF'),
      ),

      body: new Container(
          child: Container(
              child: PageIndicatorContainer(
                  child: PageView(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: PageView(
                          controller: controller,
                          children: <Widget>[
                            for (int i = 0; i < cardnum; i++)
                              _Slider(context, cardList[i], stampCheckString,
                                  i + 1),
                          ],
                        ),
                      ),
                    ],
                    controller: controller,
                  ),
                  align: IndicatorAlign.bottom,
                  length: cardnum,
                  indicatorSpace: 20.0,
                  padding: const EdgeInsets.all(10),
                  indicatorColor: Colors.white,
                  indicatorSelectorColor: Colors.grey,
                  shape: IndicatorShape.circle(size: 15)))),
      //_TotalPoint(),
    );
  }

  Widget _Slider(BuildContext context, List<Stamp> stampList,
      String stampCheckString, int number) {
    return Container(
        color: HexColor('00C2FF'),
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: _Stampcard(context, stampList, stampCheckString, number));
  }

  Widget _Stampcard(BuildContext context, List<Stamp> stampList,
      String stampCheckString, int number) {
    return Column(

        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                color: HexColor('FFFFFF'),
                child: Text(
                  number.toString(),
                  style: TextStyle(
                    fontSize: 40.0,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 4.0,
                  ),
                ),
              ),
              Text(
                '枚目',
                style: TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 4.0,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 3,
            color: Colors.black,
          ),
          SizedBox(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(10),
              // スタンプをListの数だけ生成する
              children: stampList
                  .map(
                    (Stamp stamp) => Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => stamp.data == stampCheckString
                                ? stampDialog(context, stamp)
                                : (context),
                            child: Container(
                              //padding: const EdgeInsets.all(11.0),
                              width: MediaQuery.of(context).size.width / 3 -
                                  19 * 2,
                              height: MediaQuery.of(context).size.width / 3 -
                                  19 * 2,
                              // 円を生成
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: HexColor("00FFFF"), width: 3),
                                color: HexColor('FFFFFF'),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: stamp.data == stampCheckString
                                        ? AssetImage(
                                            'assets/images/stamp/flower-4.png')
                                        : AssetImage(
                                            'assets/images/stamp/none.png')),
                              ),
                              //円内の数字表示
                              child: Align(
                                alignment: Alignment.center,
                                child: stamp.data == stampCheckString
                                    ? Text("")
                                    : Text(
                                        stamp.stampNum.toString(),
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 4.0,
                                          color: HexColor('00C2FF'),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ]);
  }

  Widget _TotalPoint(int point) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Container(
          margin: EdgeInsets.fromLTRB(10, 20, 0, 20),
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(color: HexColor('00C2FF'), width: 4),
          ),
          child: Text(
            '合計スタンプ数: $point',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.normal,
              letterSpacing: 2.0,
            ),
          ))
    ]);
  }
}
