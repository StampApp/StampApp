import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({
    required this.onNavigate,
    required Key key,
  }) : super(key: key);
  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: FloatingActionButton(
        tooltip: 'Scan',
        child: const Icon(Icons.camera),
        onPressed: onNavigate,
      ),
    );
  }
}