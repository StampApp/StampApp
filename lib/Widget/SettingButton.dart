import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    required this.onNavigate,
    required Key key,
  }) : super(key: key);
  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: IconButton(
        icon: Icon(Icons.settings),
        color: Colors.blue,
        iconSize: 60,
        onPressed: onNavigate,
      ),
    );
  }
}
