import 'package:flutter/material.dart';

class NormalTextWidget extends StatelessWidget {
  final String title;
  final Function gestureCallBack;

  NormalTextWidget({this.title, this.gestureCallBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gestureCallBack,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
