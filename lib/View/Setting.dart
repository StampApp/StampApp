import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:stamp_app/Constants/setting.dart';
import 'package:stamp_app/dbHelper.dart';
import 'package:stamp_app/dbInterface.dart';
import 'package:stamp_app/models/stamp.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Widget/AppBar.dart';
import 'package:stamp_app/Util/Enums/enumDateType.dart';
import 'package:stamp_app/Util/Enums/enumStampCount.dart';
import 'package:stamp_app/Widget/HexColor.dart';
import 'package:stamp_app/models/stampLogs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final int exchangeSpnum = StampCount.count.stampCount!; //スタンプを交換する際に必要な数

  void _termsNavigate() {
    Navigator.of(context).pushNamed('/terms');
  }

  void _privacyPolicyNavigate() {
    Navigator.of(context).pushNamed('/privacyPolicy');
  }

  void _historyNavigate() {
    Navigator.of(context).pushNamed('/history');
  }

  void _instructionsNavigate() {
    Navigator.of(context).pushNamed('/instructions');
  }

  Future<dynamic> _useStampCheck() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(10, 30, 10, 30),
          title: Text(AppLocalizations.of(context)!.confirmation),
          content: Text(
              AppLocalizations.of(context)!.exchangeStamps(exchangeSpnum) +
                  "\n" +
                  AppLocalizations.of(context)!.reallyUseStamps +
                  "\n" +
                  AppLocalizations.of(context)!.disappearStamps),
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
              onPressed: () => {Navigator.pop(context), _useStampDialog()},
            ),
          ],
        );
      },
    );
  }

  // スタンプを使用した結果を表示
  Future<dynamic> _useStampDialog() async {
    Map res = await _useStamp();

    // スタンプが足りてない場合アラートを出して終了
    if (!res['canUseStamp']) {
      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.stampUse),
              content: Text(
                  AppLocalizations.of(context)!.littleStamps(exchangeSpnum)),
              actions: <Widget>[
                // ボタン領域
                OutlinedButton(
                  child: Text(AppLocalizations.of(context)!.ok),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }

    String retCreatedAt = res['retCreatedAt'];
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.usedStamps),
          content:
              Text(AppLocalizations.of(context)!.usedStamps + "\n\n$retCreatedAt"),
          actions: <Widget>[
            // ボタン領域
            OutlinedButton(
              child: Text(AppLocalizations.of(context)!.ok),
              style: OutlinedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(color: Colors.blue),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(deviceHeight * 0.08),
          child: AppBarPage(widget.title),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: ListView(children: [
          _menuItem(AppLocalizations.of(context)!.usageHistory,
              Icon(Icons.format_list_bulleted), _historyNavigate),
          _menuItem(AppLocalizations.of(context)!.usage, Icon(Icons.menu_book),
              _instructionsNavigate),
          _menuItem(AppLocalizations.of(context)!.termsOfUse,
              Icon(Icons.verified_user_outlined), _termsNavigate),
          _menuItem(AppLocalizations.of(context)!.privacyPolicy,
              Icon(Icons.privacy_tip_outlined), _privacyPolicyNavigate),
          _menuItem(AppLocalizations.of(context)!.version,
              Icon(Icons.system_update_alt_rounded)),
        ])),
        Padding(
            padding: const EdgeInsets.all(40),
            child: OutlinedButton.icon(
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 30,
              ),
              label: Text(AppLocalizations.of(context)!.useStamp,
                  style: TextStyle(fontSize: 18)),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(220, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(color: HexColor(Setting.APP_COLOR)),
              ),
              onPressed: () => _useStampCheck(),
            )),
      ]),
    );
  }

  Widget _menuItem(String title, Icon icon, [VoidCallback? tap]) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(child: icon),
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ))
                      ])),
              //Versionか否か
              (title == "Version") ? _version() : Text("")
            ],
          )),
      //リストクリック時実行部分
      onTap: () {
        if (tap != null) {
          tap();
        }
      },
    );
  }
}

//version指定のwidget
Widget _version() {
  return GestureDetector(
    child: Text(
      Setting.VERSION,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 18.0,
      ),
    ),
  );
}

// スタンプ数を取得し規定数あった場合使用する
Future<Map> _useStamp() async {
  // useflgがfalseのスタンプ数を取得
  int count = await DbInterface.selectStampCount('Stamp', DBHelper.databese());
  final int stampCheckString = StampCount.count.stampCount!;
  // uuid
  final uuid = Uuid();

  if (count < stampCheckString) return {'retCreatedAt': null, 'canUseStamp': false};
  // useflgがfalseのスタンプを取得
  List maps = await DbInterface.selectDeleteFlg('Stamp', DBHelper.databese());

  // 更新レコードを作成
  DateTime nowDate = DateTime.now();
  List<Stamp> stampList = List.generate(maps.length, (i) {
    return Stamp(
      id: maps[i]['id'],
      data: maps[i]['data'],
      getDate: formatStringToDateTime(maps[i]['stamp_date'], EnumDateType.date),
      getTime: formatStringToDateTime(maps[i]['stamp_time'], EnumDateType.time),
      stampNum: maps[i]['stamp_num'],
      useFlg: true,
      createdAt: DateTime.parse(maps[i]['created_at']),
      deletedAt: nowDate,
    );
  });

  // LOG 記録
  List<StampLogs> logList = List.generate(maps.length, (i) {
    return StampLogs(
      id: uuid.v1(),
      stampId: maps[i]['id'],
      getDate: nowDate,
      getTime: nowDate,
      useFlg: true,
      createdAt: nowDate,
    );
  });

  String retCreatedAt = '';
  // スタンプ更新
  for (var element in stampList) {
    await DbInterface.update('Stamp', DBHelper.databese(), element);
    // 更新したIDを保持
    String createdAt = dateFormat(element.createdAt);
    retCreatedAt += '$createdAt \n';
  }

  // LOG 記録
  for (var log in logList) {
    await DbInterface.insert('StampLogs', DBHelper.databese(), log);
  }

  return {'retCreatedAt': retCreatedAt, 'canUseStamp': true};
}
