import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stamp_app/Widget/qrAlertDialog.dart';
import 'package:stamp_app/models/stamp.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:stamp_app/Widget/qrScan.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:stamp_app/Widget/HexColor.dart';
import 'package:uuid/uuid.dart';
import '../Widget/stampDialog.dart';
import '../Widget/stampMaxDialog.dart';
import '../checkIsMaxStamps.dart';
import 'package:flutter/material.dart';

import 'package:page_indicator/page_indicator.dart';

import 'package:page_view_indicators/circle_page_indicator.dart';
import '../Util/enumCheckString.dart';

class HomeSamplePage extends StatefulWidget {
  HomeSamplePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeSamplePageState createState() => _HomeSamplePageState();
}

/*
class Stamp {
  String id;
  String data;
  num stampNum;
  String createAt;
  Stamp(this.id, this.data, this.stampNum, this.createAt);
}
*/

class _HomeSamplePageState extends State<HomeSamplePage> {
  static final uuid = Uuid();
  static final DateTime dateTime = DateTime.now();

  //カード枚数は1以上
  int cardnum = 1;

  //スタンプ合計
  int stampListLen = 0;

  //カード枚数格納配列
  List<String> cardnumber = [];

  List<List<Stamp>> cardList = [];

  //pageviewで使用する
  PageController controller;
  PageController _pageController;
  int _currentPage = 0;

  Future<List<Stamp>> _getStamp;
  Future<List<List<dynamic>>> _TestStamp;

  // 画面に表示するリストを定義
  // final List<Stamp> stampList = [
  //   new Stamp(uuid.v1(), "stamp1", 1, now.toUtc().toIso8601String()),
  //   new Stamp(uuid.v1(), "stamp2", 2, now.toUtc().toIso8601String()),
  //   new Stamp(uuid.v1(), "stamp3", 3, now.toUtc().toIso8601String()),
  //   new Stamp(uuid.v1(), "stamp4", 4, now.toUtc().toIso8601String()),
  //   new Stamp(uuid.v1(), "stamp5", 5, now.toUtc().toIso8601String()),
  //   new Stamp(uuid.v1(), "stamp6", 6, now.toUtc().toIso8601String()),
  //   new Stamp(uuid.v1(), "stamp7", 7, now.toUtc().toIso8601String()),
  //   new Stamp(uuid.v1(), "stamp8", 8, now.toUtc().toIso8601String()),
  //   new Stamp(uuid.v1(), "stamp9", 9, now.toUtc().toIso8601String()),
  // ];

  // final List<Stamp> stampList = [
  //   new Stamp(
  //     id: uuid.v1(),
  //     data: "ok",
  //     getDate: dateTime,
  //     getTime: dateTime,
  //     stampNum: '1',
  //     deletedFlg: true,
  //     createdAt: dateTime,
  //     deletedAt: dateTime,
  //   ),
  //   new Stamp(
  //     id: uuid.v1(),
  //     data: "ok",
  //     getDate: dateTime,
  //     getTime: dateTime,
  //     stampNum: '2',
  //     deletedFlg: true,
  //     createdAt: dateTime,
  //     deletedAt: dateTime,
  //   ),
  //   new Stamp(
  //     id: uuid.v1(),
  //     data: "ok",
  //     getDate: dateTime,
  //     getTime: dateTime,
  //     stampNum: '3',
  //     deletedFlg: true,
  //     createdAt: dateTime,
  //     deletedAt: dateTime,
  //   ),
  //   new Stamp(
  //     id: uuid.v1(),
  //     data: "ok",
  //     getDate: dateTime,
  //     getTime: dateTime,
  //     stampNum: '4',
  //     deletedFlg: true,
  //     createdAt: dateTime,
  //     deletedAt: dateTime,
  //   ),
  //   new Stamp(
  //     id: uuid.v1(),
  //     data: "ok",
  //     getDate: dateTime,
  //     getTime: dateTime,
  //     stampNum: '5',
  //     deletedFlg: true,
  //     createdAt: dateTime,
  //     deletedAt: dateTime,
  //   ),
  //   new Stamp(
  //     id: uuid.v1(),
  //     data: "ok",
  //     getDate: dateTime,
  //     getTime: dateTime,
  //     stampNum: '6',
  //     deletedFlg: true,
  //     createdAt: dateTime,
  //     deletedAt: dateTime,
  //   ),
  //   new Stamp(
  //     id: uuid.v1(),
  //     data: "ok",
  //     getDate: dateTime,
  //     getTime: dateTime,
  //     stampNum: '7',
  //     deletedFlg: true,
  //     createdAt: dateTime,
  //     deletedAt: dateTime,
  //   ),
  //   new Stamp(
  //     id: uuid.v1(),
  //     data: "ok",
  //     getDate: dateTime,
  //     getTime: dateTime,
  //     stampNum: '8',
  //     deletedFlg: true,
  //     createdAt: dateTime,
  //     deletedAt: dateTime,
  //   ),
  //   new Stamp(
  //     id: uuid.v1(),
  //     data: "ok",
  //     getDate: dateTime,
  //     getTime: dateTime,
  //     stampNum: '9',
  //     deletedFlg: true,
  //     createdAt: dateTime,
  //     deletedAt: dateTime,
  //   ),
  // ];

  List<Stamp> stampList = [];

  static final String stampCheckString = CheckString.ok.checkStringValue;

  void _settingNavigate() {
    Navigator.of(context).pushNamed('/Setting');
  }

  void _crudSample() async {
    final DateTime dateTime = DateTime.now();
    final update = new Stamp(
      id: '4eef4900-c340-11eb-80aa-4babbebbda13',
      data: stampCheckString,
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

  Future<List<Stamp>> asyncGetStampList() async {
    //初期データなので後で消す
    var satamp1 = new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '1',
      deletedFlg: false,
      createdAt: dateTime,
      deletedAt: dateTime,
    );

    var satamp2 = new Stamp(
      id: uuid.v1(),
      data: "ok",
      getDate: dateTime,
      getTime: dateTime,
      stampNum: '2',
      deletedFlg: false,
      createdAt: dateTime,
      deletedAt: dateTime,
    );

    await DbInterface.allDelete("Stamp", Stamp.database);
    await DbInterface.insert('Stamp', Stamp.database, satamp1);
    await DbInterface.insert('Stamp', Stamp.database, satamp2);

    List<Map<String, dynamic>> maps =
        await DbInterface.allSelect('Stamp', Stamp.database);

    stampList = List.generate(maps.length, (i) {
      return Stamp(
        id: maps[i]['id'],
        data: maps[i]['data'],
        getDate: dateTime,
        getTime: dateTime,
        stampNum: maps[i]['stampnum'],
        deletedFlg: maps[i]['deleteflg'] == 0 ? true : false,
        createdAt: dateTime,
        deletedAt: dateTime,
      );
    });

    int stampListLen = stampList.length;

    //カード枚数計算
    if (stampListLen != 0) {
      cardnum = (stampListLen / 9).ceil();
    }
/*
    int num = 0;

    for (int j = 0; j < cardnum; j++) {
      List<Stamp> cardStamp = [];
      for (int i = num; i < num + 9 && i != stampListLen; i++) {
        Stamp sp = stampList[i];
        cardStamp.add(sp);
      }

      //一つのカードにStampが9個未満の場合
      if (cardStamp.length != 9) {
        int number = stampListLen;

        //一つのカードの中身を9個埋めるために空のStampデータ代入
        while (cardStamp.length < 9) {
          number++;
          Stamp noStamp = new Stamp(
            id: uuid.v1(),
            data: "",
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
      print(cardList.length);
      num = num + 9;
    }*/

    //GridViewのcrossAxisCountの値
    int crossAxisCount = 3;
    int listRow = stampListLen ~/ crossAxisCount + 1;
    if (!(crossAxisCount < listRow)) {
      listRow = 3;
    }
    for (int i = stampListLen + 1; i <= listRow * crossAxisCount; i++) {
      Stamp newStamp = new Stamp(
          id: uuid.v1(),
          data: "",
          getDate: dateTime,
          getTime: dateTime,
          stampNum: (i).toString(),
          deletedFlg: false,
          createdAt: dateTime,
          deletedAt: dateTime);
      stampList.add(newStamp);
    }

    return stampList;
  }

  Future<void> _qrScan() async {
    ScanResult result = await qrScan();
    final DateTime dateTime = DateTime.now();

    if (result.rawContent != "データが不正です" &&
        result.type.name != "Error" &&
        result.type.name != "Cancelled") {
      dynamic resultJson = json.decode(result.rawContent);

      if (result.format.name == "qr" &&
          resultJson["data"] == stampCheckString) {
        int maxStamp = 0; //上限無しの場合0を指定
        int stampListLen = stampList.length;
        int crossAxisCount = 3;
        int successStampLen = stampList
            .where((element) => element.data == stampCheckString)
            .length;

        if (checkIsMaxStamps(successStampLen, maxStamp)) {
          if (successStampLen >= maxStamp) {
            stampMaxDialogAlert(context, maxStamp);
          } else {
            Stamp newStamp = new Stamp(
                id: uuid.v1(),
                data: stampCheckString,
                getDate: dateTime,
                getTime: dateTime,
                stampNum: resultJson["stampNum"],
                deletedFlg: false,
                createdAt: dateTime,
                deletedAt: dateTime);
            await DbInterface.insert('Stamp', Stamp.database, newStamp);
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
                  stampNum: "",
                  deletedFlg: false,
                  createdAt: dateTime,
                  deletedAt: dateTime);
              stampList.add(newStamp);
            }
          }
          Stamp newStamp = new Stamp(
              id: uuid.v1(),
              data: stampCheckString,
              getDate: dateTime,
              getTime: dateTime,
              stampNum: resultJson["stampNum"],
              deletedFlg: false,
              createdAt: dateTime,
              deletedAt: dateTime);
          await DbInterface.insert('Stamp', Stamp.database, newStamp);
          setState(() {
            stampList[successStampLen] = newStamp;
          });
        }
      } else {
        String title = "エラー";
        String text =
            result.format.name != "qr" ? "これはQRコードではありません" : "このQRコードは無効です";
        qrAlertDialog(context, title, text);
      }
    } else if (result.type.name != "Cancelled") {
      String title = "エラー";
      String text = '不正なQRコードです\n${result.rawContent}';
      qrAlertDialog(context, title, text);
    }
  }

  @override
  void initState() {
    super.initState();

    _getStamp = asyncGetStampList();
    //_TestStamp = asyncGetStampList();

    stampListLen = stampList.length;

    /*
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

        //一つのカードの中身を9個埋めるために空のStampデータ代入
        while (cardStamp.length < 9) {
          number++;
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
    }*/
  }

  //pageviewで使用
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffoldは画面構成の基本Widget
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //ロゴを中央にしたい場合↓
              //padding: const EdgeInsets.all(8.0), child: Text('         ')),
              Image.asset(
                "assets/images/other/logo_Contrast.png",
                fit: BoxFit.contain,
                height: 50,
              ),
              Container(padding: EdgeInsets.only(left: 200))
            ],
          ),
          actions: <Widget>[
            // 設定ボタン
            IconButton(
              icon: Icon(Icons.settings,
                  color: Colors.white, size: deviceWidth * 0.07),
              onPressed: _settingNavigate,
            ),
          ],
          backgroundColor: HexColor('00C2FF'),
        ),
        // QRへ遷移
        floatingActionButton: FloatingActionButton.extended(
          label: Text('QR',
              style: TextStyle(
                fontSize: deviceWidth * 0.06,
                fontStyle: FontStyle.normal,
                letterSpacing: 4.0,
              )),
          icon: Icon(Icons.qr_code),
          onPressed: _qrScan,
          backgroundColor: HexColor('00C2FF'),
        ),
        body: Column(children: [
          Expanded(
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
                                  _Slider(context, stampCheckString, i + 1,
                                      deviceWidth),
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
                      indicatorColor: Colors.grey,
                      indicatorSelectorColor: Colors.black,
                      shape: IndicatorShape.circle(size: 15)))),
          _TotalPoint(stampListLen, deviceWidth, deviceHeight)
        ]));
  }

  Widget _Slider(BuildContext context, String stampCheckString, int number,
      double deviceWidth) {
    return Container(
        color: HexColor('00C2FF').withOpacity(0.6),
        margin: EdgeInsets.fromLTRB(deviceWidth / 20, deviceWidth / 18,
            deviceWidth / 20, deviceWidth / 10),
        width: deviceWidth / 4 - 4 * 1,
        height: deviceWidth / 4 - 4 * 1,
        child: _Stampcard(context, stampCheckString, number, deviceWidth));
  }

  Widget _Stampcard(BuildContext context, String stampCheckString, int number,
      double deviceWidth) {
    return SingleChildScrollView(
      child: Column(
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
                    fontSize: deviceWidth * 0.1,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 4.0,
                  ),
                ),
              ),
              Text(
                '枚目',
                style: TextStyle(
                  fontSize: deviceWidth * 0.06,
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
            height: MediaQuery.of(context).size.width,
            child: FutureBuilder(
                future: _getStamp,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Stamp>> snapshot) {
                  Widget childWidget;
                  if (snapshot.hasData) {
                    childWidget = GridView.count(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => stamp.data == stampCheckString
                                        ? stampDialog(context, stamp)
                                        : (context),
                                    child: Container(
                                      //padding: const EdgeInsets.all(11.0),
                                      width: MediaQuery.of(context).size.width /
                                              4 -
                                          4 * 1,
                                      height:
                                          MediaQuery.of(context).size.width /
                                                  4 -
                                              4 * 1,
                                      // 円を生成
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        //border: Border.all(
                                        //  color: HexColor("00FFFF"), width: 3),
                                        color: HexColor('FFFFFF'),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: stamp.data ==
                                                    stampCheckString
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
                    );
                  } else {
                    childWidget = const CircularProgressIndicator();
                  }
                  return childWidget;
                }),
          ),
        ],
      ),
    );
  }

  Widget _TotalPoint(int point, double deviceWidth, double deviceHeight) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Container(
          margin:
              EdgeInsets.fromLTRB(deviceWidth / 20, deviceHeight / 85, 0, 25),
          width: deviceWidth / 2 * 1,
          height: deviceHeight / 16 * 1,
          decoration: BoxDecoration(
            border: Border.all(
                color: HexColor('00C2FF').withOpacity(0.6), width: 3),
          ),
          child: Text(
            '合計スタンプ数: $point',
            style: TextStyle(
              fontSize: deviceHeight * 0.028,
              fontStyle: FontStyle.normal,
              letterSpacing: 2.0,
            ),
          ))
    ]);
  }
}
