import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    this.onTap,
    Key key,
  }) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FloatingActionButton(
        tooltip: 'Scan',
        child: Icon(Icons.camera),
      ),
    );
  }
}
