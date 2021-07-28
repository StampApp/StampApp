import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stamp_app/Constants/setting.dart';
import 'package:stamp_app/Widget/qrAlertDialog.dart';
import 'package:stamp_app/dbHelper.dart';
import 'package:stamp_app/models/stamp.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:stamp_app/Widget/qrScan.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:stamp_app/Widget/HexColor.dart';
import 'package:stamp_app/models/stampLogs.dart';
import 'package:uuid/uuid.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widget/stampDialog.dart';
import '../Widget/stampMaxDialog.dart';
import '../Util/checkIsMaxStamps.dart';
import '../Util/Enums/enumCheckString.dart';

class HomeSamplePage extends StatefulWidget {
  HomeSamplePage({Key key, this.title, this.routeObserver}) : super(key: key);
  final String title;
  final RouteObserver<PageRoute> routeObserver;

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
class AppBackground extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return LayoutBuilder(builder: (context, contraint) {
     final height = contraint.maxHeight;
     final width = contraint.maxWidth;
     return Stack(
       children: <Widget>[
         Container(
           color: HexColor("e0ffff")
         ),
         Positioned(
           top: height * 0.20,
           left: height * 0.35,
           child: Container(
             height: height,
             width: width,
             decoration: BoxDecoration(
                 shape: BoxShape.circle, color: HexColor(
                                                      Setting.APP_COLOR).withAlpha(70)),
           ),
         ),
         Positioned(
           top: -height * 0.10,
           left: -height * 0.39,
           child: Container(
             height: height,
             width: width,
             decoration: BoxDecoration(
                 shape: BoxShape.circle, color: HexColor(
                                                      Setting.APP_COLOR).withAlpha(50)),
           ),
         ),
       ],
     );
   });
 }
}

class _HomeSamplePageState extends State<HomeSamplePage> with RouteAware {
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

  Future<List<Stamp>> _getStamp;

  List<Stamp> stampList = [];

  static final String stampCheckString = CheckString.ok.checkStringValue;

  void _settingNavigate() {
    Navigator.of(context).pushNamed('/Setting');
  }

  Future<List<Stamp>> asyncGetStampList() async {
    List<Map<String, dynamic>> maps =
        await DbInterface.selectDeleteFlg('Stamp', DBHelper.databese());

    stampListLen = maps.length;

    stampList = List.generate(maps.length, (i) {
      return Stamp(
        id: maps[i]['id'],
        data: maps[i]['data'],
        getDate: dateTime,
        getTime: dateTime,
        stampNum: maps[i]['stamp_num'],
        useFlg: maps[i]['useflg'] == 0 ? true : false,
        createdAt: dateTime,
        deletedAt: dateTime,
      );
    });

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
          useFlg: false,
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
        int maxStamp = 9; //上限無しの場合0を指定
        int localListLen = stampList.length;
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
                useFlg: false,
                createdAt: dateTime,
                deletedAt: dateTime);
            await DbInterface.insert('Stamp', DBHelper.databese(), newStamp);

            // LOG 記録
            StampLogs newLogs = new StampLogs(
              id: uuid.v1(),
              stampId: newStamp.id,
              getDate: dateTime,
              getTime: dateTime,
              useFlg: false,
              createdAt: dateTime,
            );

            await DbInterface.insert('StampLogs', DBHelper.databese(), newLogs);
            print(
                await DbInterface.allSelect('StampLogs', DBHelper.databese()));

            setState(() {
              stampList[successStampLen] = newStamp;
            });
            stampMaxDialogAlert(context, maxStamp);
          }
        } else {
          if (localListLen == successStampLen + 1) {
            for (int i = localListLen; i < localListLen + crossAxisCount; i++) {
              Stamp newStamp = new Stamp(
                  id: uuid.v1(),
                  data: "",
                  getDate: dateTime,
                  getTime: dateTime,
                  stampNum: "",
                  useFlg: false,
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
              useFlg: false,
              createdAt: dateTime,
              deletedAt: dateTime);
          await DbInterface.insert('Stamp', DBHelper.databese(), newStamp);

          // LOG 記録
          StampLogs newLogs = new StampLogs(
            id: uuid.v1(),
            stampId: newStamp.id,
            getDate: dateTime,
            getTime: dateTime,
            useFlg: false,
            createdAt: dateTime,
          );
          await DbInterface.insert('StampLogs', DBHelper.databese(), newLogs);
          print(await DbInterface.allSelect('StampLogs', DBHelper.databese()));

          List<dynamic> countstamp =
              await DbInterface.allSelect('Stamp', DBHelper.databese());
          setState(() {
            stampListLen = countstamp.length;
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

    List<dynamic> countstamp =
        await DbInterface.selectDeleteFlg('Stamp', DBHelper.databese());
    stampListLen = countstamp.length;
  }

  @override
  void initState() {
    super.initState();

    _getStamp = asyncGetStampList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  // @override
  // void didPush() {
  //   // 画面が初めて表示 (Push) される時にコールされます。
  //   print("画面が初めて表示 (Push) される時にコールされます。");
  // }

  // @override
  // void didPop() {
  //   // この画面から別の画面に遷移する (Pop) 場合にコールされます。
  //   print("この画面から別の画面に遷移する (Pop) 場合にコールされます。");
  // }

  // @override
  // void didPushNext() {
  //   // この画面から別の画面をPushする場合にコールされます (この画面はPopされずにそのまま残る場合)。
  //   print("この画面から別の画面をPushする場合にコールされます (この画面はPopされずにそのまま残る場合)。");
  // }

  @override
  Future<void> didPopNext() async {
    // 一度、別の画面に遷移したあとで、再度この画面に戻ってきた時にコールされます。
    // print("一度、別の画面に遷移したあとで、再度この画面に戻ってきた時にコールされます。");
    int existStampNum =
        await DbInterface.selectStampCount('Stamp', DBHelper.databese());
    int thisExistStampNum =
        stampList.where((element) => element.data == stampCheckString).length;
    if (existStampNum == 0 && thisExistStampNum == stampListLen) {
      List<Stamp> newStampList = [];
      for (int i = 0; i < stampList.length; i++) {
        Stamp newStamp = new Stamp(
            id: uuid.v1(),
            data: "",
            getDate: dateTime,
            getTime: dateTime,
            stampNum: (i + 1).toString(),
            useFlg: false,
            createdAt: dateTime,
            deletedAt: dateTime);
        newStampList.add(newStamp);
      }
      setState(() {
        stampList = newStampList;
      });
    }
  }

  //pageviewで使用
  void dispose() {
    widget.routeObserver.unsubscribe(this);
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
                Setting.APP_LOGO,
                fit: BoxFit.contain,
                height: 50,
              ),
              Container(padding: EdgeInsets.only(left: 190))
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
          backgroundColor: HexColor(Setting.APP_COLOR),
        ),
        // QRへ遷移
        floatingActionButton:Container(
          margin:EdgeInsets.fromLTRB(0,0,deviceWidth/90,deviceWidth/30),
          child:FloatingActionButton.extended(
          label: Text('QR',
              style: TextStyle(
                fontSize: deviceWidth * 0.06,
                fontStyle: FontStyle.normal,
                letterSpacing: 4.0,
              )),
          icon: Icon(Icons.qr_code),
          onPressed: _qrScan,
          backgroundColor: HexColor(Setting.APP_COLOR),
        )),
        body:Stack(children:[AppBackground(),
            FutureBuilder(
            future: _getStamp,
            builder:
                (BuildContext context, AsyncSnapshot<List<Stamp>> snapshot) {
              Widget childWidget;
              if (snapshot.connectionState == ConnectionState.done) {
                childWidget = Column(children: [
                  Expanded(
                      child: Container(
                    child: PageView(
                      children: <Widget>[PageView(
                          controller: controller,
                          children: <Widget>[
                            _slider(context, stampCheckString, deviceWidth,deviceHeight)
                          ],
                        ),
                      ],
                      controller: controller,
                    ),
                  )),
                ]);
              } else {
                childWidget = const CircularProgressIndicator();
              }
              return childWidget;
            })]));
  }

  Widget _slider(
      BuildContext context, String stampCheckString, double deviceWidth,double deviceHeight) {
    return Container(
        color : Colors.white70,
        margin: EdgeInsets.fromLTRB(
            deviceWidth / 20,
            MediaQuery.of(context).size.height * 0.07,
            deviceWidth / 20,
            MediaQuery.of(context).size.height * 0.1),
        height: MediaQuery.of(context).size.height * 0.73,
        child: _stampCard(context, stampCheckString, deviceWidth,deviceHeight));
  }

  Widget _stampCard(
      BuildContext context, String stampCheckString, double deviceWidth,double deviceHeight) {
    return SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child:_totalPoint(stampListLen, deviceWidth, deviceHeight)),
          SizedBox(
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
                      childAspectRatio: MediaQuery.of(context).size.width > 600
                          ? (MediaQuery.of(context).size.height /
                              MediaQuery.of(context).size.width *
                              0.93)
                          : 1,
                      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.01, 0, 10),
                      // スタンプをListの数だけ生成する
                      children: stampList
                          .map(
                            (Stamp stamp) => Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () =>
                                          stamp.data == stampCheckString
                                              ? stampDialog(context, stamp)
                                              : (context),
                                      child: Container(
                                        //padding: const EdgeInsets.all(10.0),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    4 -
                                                4 * 1,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                    4 -
                                                4 * 1,
                                        // 円を生成
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: HexColor(Setting.APP_COLOR).withOpacity(0.6),width:3),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: stamp.data ==
                                                      stampCheckString
                                                  ? AssetImage(
                                                      stamp.stampNum.toString())
                                                  : AssetImage(
                                                      Setting.NONE_IMG)),
                                        ),
                                        //円内の数字表示
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: stamp.data == stampCheckString
                                              ? Text("")
                                              : Text(
                                                  stamp.stampNum.toString(),
                                                  style: GoogleFonts.prompt(
                                                    fontSize:deviceWidth * 0.09,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                          ),
                                    ),
                                  ),
                                ],
                               ),
                            ),)
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

  Widget _totalPoint(int point, double deviceWidth, double deviceHeight) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Container(
          alignment: Alignment.center,
          margin:
              EdgeInsets.fromLTRB(deviceWidth / 8, deviceWidth/20, 0, deviceWidth/50),
          width: deviceWidth / 2 * 1.3,
          height: deviceHeight / 16 * 1.2,
          /*decoration: BoxDecoration(
            border: Border.all(
                color: HexColor(Setting.APP_COLOR).withOpacity(0.6), width: 3),
          ),*/
          child: Text(
            '合計スタンプ数: $point',
            style: GoogleFonts.ubuntu(
              fontSize: deviceWidth*0.07,
              fontWeight: FontWeight.w500,
            ),
          ))
    ]);
  }
}