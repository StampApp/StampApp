import 'package:flutter/material.dart';

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
    Navigator.of(context).pushNamed('/homeTest/qrReader');
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
              onPressed: () {
                // Pressed Action
              },
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
            SizedBox(height: 60,),
            Text(
              '獲得スタンプ',
              style: TextStyle(
                  fontSize: 32.0,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 4.0,
                ),
            ),
           SizedBox(height: 60,),
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
                    border: Border.all(
                      color: HexColor('00C2FF'),
                      width: 3
                    ),
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
                    border: Border.all(
                      color: HexColor('00C2FF'),
                      width: 3
                    ),
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
                    border: Border.all(
                      color: HexColor('00C2FF'),
                      width: 3
                    ),
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
          SizedBox(height: 60,),
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
                        border: Border.all(
                          color: HexColor('00C2FF'),
                          width: 3
                        ),
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
                        border: Border.all(
                          color: HexColor('00C2FF'),
                          width: 3
                        ),
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
                        border: Border.all(
                          color: HexColor('00C2FF'),
                          width: 3
                        ),
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
          SizedBox(height: 60,),
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
                    border: Border.all(
                      color: HexColor('00C2FF'),
                      width: 3
                    ),
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
                    border: Border.all(
                      color: HexColor('00C2FF'),
                      width: 3
                    ),
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
                    border: Border.all(
                      color: HexColor('00C2FF'),
                      width: 3
                    ),
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
          ],
        ),
      ),
    );
  }
}