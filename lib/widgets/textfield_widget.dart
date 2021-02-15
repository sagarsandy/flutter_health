import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Function validateFieldValue;
  final Color textColor;
  final IconData icon;

  TextFieldWidget({
    this.textEditingController,
    this.hintText,
    this.validateFieldValue,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: textEditingController,
      validator: validateFieldValue,
      decoration: InputDecoration(
        suffixIconConstraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
        suffixIcon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
