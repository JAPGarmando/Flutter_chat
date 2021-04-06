import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;
  ErrorMessage({this.errorMessage});
  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: TextStyle(
          fontSize: 13,
          color: Colors.red,
          height: 1,
          fontWeight: FontWeight.w300),
    );
  }
}
