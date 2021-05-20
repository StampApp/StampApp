import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({
    this.onNavigate,
    Key key,
  }) : super(key: key);
  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: FloatingActionButton(
        tooltip: 'Scan',
        child: Icon(Icons.camera),
        onPressed: onNavigate,
      ),
    );
  }
}