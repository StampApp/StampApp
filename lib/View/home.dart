import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:stamp_app/Widget/qrScan.dart';
import 'package:stamp_app/models/memo.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:uuid/uuid.dart';
import '../Widget/stampDialog.dart';
import '../Widget/stampMaxDialog.dart';

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
    new Stamp(uuid.v1(), "ok", 1, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "ok", 2, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "ok", 3, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "ok", 4, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "ok", 5, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "ok", 6, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "ok", 7, now.toUtc().toIso8601String()),
    new Stamp(uuid.v1(), "ok", 8, now.toUtc().toIso8601String()),
  ];

  void _settingNavigate() {
    Navigator.of(context).pushNamed('/Setting');
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

  bool checkIsMaxStamps(int okLen, int maxStamp) {
    //上限無しの場合0を指定
    if (maxStamp == 0) return false;
    if (okLen + 1 >= maxStamp) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _qrScan() async {
    ScanResult result = await qrScan();
    if (result.format.name == "qr") {
      int maxStamp = 9; //上限無しの場合0を指定
      int stampListLen = stampList.length;
      int crossAxisCount = 3;
      int okLen = stampList.where((element) => element.data == "ok").length;

      if (checkIsMaxStamps(okLen, maxStamp)) {
        if (okLen >= maxStamp) {
          stampMaxDialogAlert(context, maxStamp);
        } else {
          Stamp newStamp = new Stamp(uuid.v1(), "ok", okLen + 1,
              DateTime.now().toUtc().toIso8601String());
          setState(() {
            stampList[okLen] = newStamp;
          });
          stampMaxDialogAlert(context, maxStamp);
        }
      } else {
        if (stampListLen == okLen + 1) {
          for (int i = stampListLen; i < stampListLen + crossAxisCount; i++) {
            Stamp newStamp =
                new Stamp(uuid.v1(), "", i + 1, now.toUtc().toIso8601String());
            stampList.add(newStamp);
          }
        }
        Stamp newStamp = new Stamp(uuid.v1(), "ok", okLen + 1,
            DateTime.now().toUtc().toIso8601String());
        setState(() {
          stampList[okLen] = newStamp;
        });
      }
    }
  }

  @override
  void initState() {
    //アプリ起動時に一度だけ実行される、がここのコードは未完成
    int stampListLen = stampList.length;
    //GridViewのcrossAxisCountの値
    int crossAxisCount = 3;
    int listRow = stampListLen ~/ crossAxisCount + 1;
    crossAxisCount < listRow ? null : listRow = 3;
    for (int i = stampListLen + 1; i <= listRow * crossAxisCount; i++) {
      Stamp newStamp =
          new Stamp(uuid.v1(), "", i, now.toUtc().toIso8601String());
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
                              onTap: () => stamp.data == "ok"
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
                                      image: stamp.data == "ok"
                                          ? AssetImage(
                                              'assets/images/flower-4.png')
                                          : AssetImage(
                                              'assets/images/none.png')),
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
            ElevatedButton(child: Text('DBサンプル'), onPressed: _demoCRUD)
          ],
        ),
      ),
    );
  }
}
