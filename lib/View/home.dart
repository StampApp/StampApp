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

class Stamp {
  String id;
  String data;
  num stampNum;
  String createAt;
  Stamp(this.id, this.data, this.stampNum, this.createAt);
}

class _HomeSamplePageState extends State<HomeSamplePage> {
  static final DateTime now = DateTime.now();
  static final uuid = Uuid();

  // 画面に表示するリストを定義
  final List<Stamp> stampList = [
    new Stamp(uuid.v1(), "stamp1", 1, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "stamp2", 2, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "stamp3", 3, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "stamp4", 4, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "stamp5", 5, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "stamp6", 6, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "stamp7", 7, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "stamp8", 8, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "stamp9", 9, now.toUtc().toIso8601String()),
  ];

  void _settingNavigate() {
    Navigator.of(context).pushNamed('/Setting');
  }

  void _crudSample() async {
    DateTime dateTime = DateTime.now();
    DateTime getDate = dateTime;
    DateTime getTime = dateTime;
    DateTime createdAt = dateTime;
    DateTime deletedAt = dateTime;
    // 挿入データ
    var stamp = Stamp(
      id: '0',
      stampInfo: '6D',
      getDate: getDate,
      getTime: getTime,
      stampNum: '1',
      deletedFlg: true,
      createdAt: createdAt,
      deletedAt: deletedAt,
    );
    var stamp2 = Stamp(
      id: '1',
      stampInfo: '5D',
      getDate: getDate,
      getTime: getTime,
      stampNum: '2',
      deletedFlg: true,
      createdAt: createdAt,
      deletedAt: deletedAt,
    );
    var stamp3 = Stamp(
      id: '1',
      stampInfo: '3F',
      getDate: getDate,
      getTime: getTime,
      stampNum: '2',
      deletedFlg: true,
      createdAt: createdAt,
      deletedAt: deletedAt,
    );

    await DbInterface.insert('Stamp', Stamp.database, stamp);

    print(await DbInterface.select('Stamp', Stamp.database, 0));

    await DbInterface.insert('Stamp', Stamp.database, stamp2);

    await DbInterface.update('Stamp', Stamp.database, stamp3);

    print(await DbInterface.select('Stamp', Stamp.database, 1));

    await DbInterface.delete('Stamp', Stamp.database, 0);
  }

  void _demoCRUD() async {
    var memo = Memo(
      id: 0,
      text: 'Flutterで遊ぶ',
      priority: 1,
    );

    await DbInterface.insert('memo', Memo.database, memo);

    print(await DbInterface.select('memo', Memo.database, memo.id));

    memo = Memo(
      id: memo.id + 1,
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
    if (result.format.name == "qr") {
      Stamp newStamp = new Stamp(uuid.v1(), result.rawContent,
          stampList.length + 1, now.toUtc().toIso8601String());
      setState(() {
        stampList.add(newStamp);
      });
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
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              padding: const EdgeInsets.all(10),
              // スタンプをListの数だけ生成する
              children: stampList
                  .map(
                    (Stamp stamp) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => stampDialog(context, stamp),
                          child: Container(
                            padding: const EdgeInsets.all(11.0),
                            width: 60,
                            height: 60,
                            // 円を生成
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                  color: HexColor('00C2FF'), width: 3),
                            ),
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
                      ],
                    ),
                  )
                  .toList(),
            ),
            ElevatedButton(child: Text('DBサンプル'), onPressed: _demoCRUD),
            ElevatedButton(child: Text('CRUDサンプル'), onPressed: _crudSample)
          ],
        ),
      ),
    );
  }
}
