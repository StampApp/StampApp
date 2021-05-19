import 'package:flutter/material.dart';
import 'package:stamp_app/models/memo.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:uuid/uuid.dart';

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

   void _qrNavigate() {
    Navigator.of(context).pushNamed('/qrReader');
  }

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
        onPressed: _qrNavigate,
        backgroundColor: HexColor('00C2FF'),
      ),
      body: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 30,),
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
                  children: stampList.map((Stamp stamp) =>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(11.0),
                          width: 60,
                          height: 60,
                          // 円を生成
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: HexColor('00C2FF'),
                                width: 3
                              ),
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
                      ],
                    ),
                  ).toList(),
                ),
            ElevatedButton(
              child: Text('DBサンプル'),
              onPressed: _demoCRUD
            )
          ],
        ),
      ),
    );
  }
}