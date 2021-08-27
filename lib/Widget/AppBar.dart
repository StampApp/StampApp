import 'package:flutter/material.dart';
import 'package:stamp_app/Constants/setting.dart';
import 'package:stamp_app/Util/HexColor.dart';

class AppBarPage extends StatefulWidget{
  AppBarPage(this.title);
  final String title;

  @override
  _HeaderPageState createState() => _HeaderPageState();
}

// ヘッダー(現在はホーム画面とQRスキャン画面以外)
class _HeaderPageState extends State<AppBarPage>{
  
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    return AppBar(
      // AppBar中の幅切れ防止
      toolbarHeight: 100,
      // アプリカラーの適用
      backgroundColor: HexColor(Setting.APP_COLOR),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 各ページのタイトルを表示
          Text(widget.title,
            style: TextStyle(fontSize: deviceHeight * 0.032))
      ]),
      // 戻るボタンの大きさ調整
      leading: IconButton(
        icon: Icon(Icons.arrow_back,
          color: Colors.white, size: deviceHeight * 0.032),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}