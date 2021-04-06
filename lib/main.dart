import 'package:flutter/material.dart';
import 'package:flutter_chat/src/screens/chat_screen.dart';
import 'package:flutter_chat/src/screens/login_screen.dart';
import 'package:flutter_chat/src/screens/register_screen.dart';
import 'package:flutter_chat/src/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
    initialRoute: WelcomeScreen.routeName,
    routes: {
      WelcomeScreen.routeName: (BuildContext context) => WelcomeScreen(),
      LoginScreen.routeName: (BuildContext context) => LoginScreen(),
      RegisterScreen.routeName: (BuildContext context) => RegisterScreen(),
      ChatScreen.routeName: (BuildContext context) => ChatScreen(),
    },
    theme: ThemeData(
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black45))),
  ));
}
