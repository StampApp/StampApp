import 'package:flutter/material.dart';
import 'package:stamp_app/Constants/setting.dart';
import 'package:stamp_app/Widget/HexColor.dart';

class AppBarPage extends StatefulWidget{
  AppBarPage(this.title);
  final String title;

  @override
  _HeaderPageState createState() => _HeaderPageState();
}

class _HeaderPageState extends State<AppBarPage>{
  
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    return AppBar(
      backgroundColor: HexColor(Setting.APP_COLOR),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.title,
              style: TextStyle(fontSize: deviceHeight * 0.032))]),
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                color: Colors.white, size: deviceHeight * 0.032),
              onPressed: () => Navigator.of(context).pop(),
            ),
    );
 }
}