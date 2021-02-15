import 'package:flutter/material.dart';

class RoundRectButtonWidget extends StatelessWidget {
  final String title;
  final Function gestureCallBack;

  RoundRectButtonWidget({this.title, this.gestureCallBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gestureCallBack,
      child: Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0XFF29A9E0),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
