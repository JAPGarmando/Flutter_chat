import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String textButton;
  final Color colorBackground;
  final VoidCallback onPressed;
  const AppButton(
      {Key key,
      this.textButton = "Log in",
      this.colorBackground = Colors.blueAccent,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        color: colorBackground,
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          height: 50,
          child: TextButton(
              onPressed: onPressed,
              child: Text(
                textButton,
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
