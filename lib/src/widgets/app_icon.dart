import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, //Center Row contents horizontally,
      crossAxisAlignment:
          CrossAxisAlignment.center, //Center Row contents vertically,
      children: [
        Image.asset(
          'images/chat.gif',
          width: 50,
        ),
        Text(
          "Flutter Chat",
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.w700, color: Colors.black54),
        ),
      ],
    );
  }
}
