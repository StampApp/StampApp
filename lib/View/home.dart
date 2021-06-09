import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    int listRow = stampListLen ~/ crossAxisCount + 1;
    crossAxisCount < listRow ? null : listRow = 3;
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
  }

  @override
  Widget build(BuildContext context) {
    // Scaffoldは画面構成の基本Widget
    return Scaffold(
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
      body: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              '獲得スタンプ',
              style: TextStyle(
                fontSize: 32.0,
                fontStyle: FontStyle.normal,
                letterSpacing: 4.0,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width,
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
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => stamp.data == stampCheckString
                                  ? stampDialog(context, stamp)
                                  : (context),
                              child: Container(
                                padding: const EdgeInsets.all(11.0),
                                width: MediaQuery.of(context).size.width / 3 -
                                    11 * 2,
                                height: MediaQuery.of(context).size.width / 3 -
                                    11 * 2,
                                // 円を生成
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: stamp.data == stampCheckString
                                          ? AssetImage(
                                              'assets/images/stamp/flower-4.png')
                                          : AssetImage(
                                              'assets/images/stamp/none.png')),
                                  // border: Border.all(
                                  //     color: HexColor('00C2FF'), width: 3),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    stamp.stampNum.toString(),
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 4.0,
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
            ElevatedButton(child: Text('DBサンプル'), onPressed: _demoCRUD),
            ElevatedButton(child: Text('CRUDサンプル'), onPressed: _crudSample)
          ],
        ),
      ),
    );
  }
}
