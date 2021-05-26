import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stamp_app/models/stamp.dart';
import 'package:stamp_app/models/memo.dart';
import 'package:stamp_app/dbInterface.dart';

class HomeSamplePage extends StatefulWidget {
  HomeSamplePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeSamplePageState createState() => _HomeSamplePageState();
}

//カラーコードをHexColorでできるように
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
  void _qrNavigate() {
    Navigator.of(context).pushNamed('/qrReader');
  }

  void _settingNavigate() {
    Navigator.of(context).pushNamed('/Setting');
  }

  void _crudSample() async {
    DateTime datetime = DateTime.now();
    DateTime getdate = datetime;
    DateTime gettime = datetime;
    DateTime deleteat = datetime;
    DateTime deletetime = datetime;
    //挿入データ
    var stamp = Stamp(
        id: '0',
        stampinfo: '6D',
        getdate: getdate,
        gettime: gettime,
        invalidflg: true,
        deleteat: deleteat,
        deletetime: deletetime,
        stampnum: 1);
    var stamp2 = Stamp(
        id: '1',
        stampinfo: '5D',
        getdate: getdate,
        gettime: gettime,
        invalidflg: true,
        deleteat: deleteat,
        deletetime: deletetime,
        stampnum: 2);
    var stamp3 = Stamp(
        id: '1',
        stampinfo: '3F',
        getdate: getdate,
        gettime: gettime,
        invalidflg: true,
        deleteat: deleteat,
        deletetime: deletetime,
        stampnum: 2);

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
      id: memo.id,
      text: memo.text,
      priority: memo.priority + 1,
    );

    await DbInterface.update('memo', Memo.database, memo);

    print(await DbInterface.select('memo', Memo.database, memo.id));

    await DbInterface.delete('memo', Memo.database, memo.id);

    print(await DbInterface.select('memo', Memo.database, memo.id));
  }

  @override
  Widget build(BuildContext context) {
    // Scaffoldは画面構成の基本Widget
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          //設定ボタン
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white, size: 38),
            onPressed: _settingNavigate,
          ),
        ],
        backgroundColor: HexColor('00C2FF'),
      ),
      //QRへ遷移
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
        onPressed: _qrNavigate,
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
              height: 40,
            ),
            //丸作成
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: HexColor('00C2FF'), width: 3),
                  ),
                  child: const Text(
                    '１',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 4.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: HexColor('00C2FF'), width: 3),
                  ),
                  child: const Text(
                    '２',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 4.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: HexColor('00C2FF'), width: 3),
                  ),
                  child: const Text(
                    '３',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 4.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: HexColor('00C2FF'), width: 3),
                  ),
                  child: const Text(
                    '４',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 4.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: HexColor('00C2FF'), width: 3),
                  ),
                  child: const Text(
                    '５',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 4.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: HexColor('00C2FF'), width: 3),
                  ),
                  child: const Text(
                    '６',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 4.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: HexColor('00C2FF'), width: 3),
                  ),
                  child: const Text(
                    '７',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 4.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: HexColor('00C2FF'), width: 3),
                  ),
                  child: const Text(
                    '８',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 4.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: HexColor('00C2FF'), width: 3),
                  ),
                  child: const Text(
                    '９',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 4.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(child: Text('DBサンプル'), onPressed: _demoCRUD),
            ElevatedButton(child: Text('CRUDサンプル'), onPressed: _crudSample)
          ],
        ),
      ),
    );
  }
}
