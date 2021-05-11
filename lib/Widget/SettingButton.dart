import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      color: Colors.blue,
      iconSize: 60,
      onPressed: () {
        Navigator.of(context).pushNamed('/qrReader');
      },
    );
  }
}
