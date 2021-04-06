import 'package:flutter/material.dart';
import 'package:flutter_chat/src/screens/login_screen.dart';
import 'package:flutter_chat/src/screens/register_screen.dart';
import 'package:flutter_chat/src/widgets/app_button.dart';
import 'package:flutter_chat/src/widgets/app_icon.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = "";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppIcon(),
          SizedBox(
            height: 40,
          ),
          AppButton(
            textButton: "Log In",
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
          ),
          AppButton(
            textButton: "Register",
            colorBackground: Colors.lightBlue[300],
            onPressed: () {
              Navigator.pushNamed(context, RegisterScreen.routeName);
            },
          ),
        ],
      ),
    ));
  }
}
