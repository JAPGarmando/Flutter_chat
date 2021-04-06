import 'package:flutter/material.dart';
import 'package:flutter_chat/src/mixins/validation_mixins.dart';
import 'package:flutter_chat/src/screens/chat_screen.dart';
import 'package:flutter_chat/src/services/authentication.dart';
import 'package:flutter_chat/src/widgets/app_button.dart';
import 'package:flutter_chat/src/widgets/app_error_message.dart';
import 'package:flutter_chat/src/widgets/app_icon.dart';
import 'package:flutter_chat/src/widgets/app_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  static final String routeName = "/register";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationMixins {
  final auth = FirebaseAuth.instance;
  FocusNode _focusNode;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _errorMessage = "";
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppIcon(),
              SizedBox(height: 18),
              _emailField(),
              SizedBox(height: 18),
              _passwordField(),
              SizedBox(height: 18),
              _showErrorMessage(),
              _sumbmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return AppTextField(
      focusNode: _focusNode,
      validator: validateEmail,
      controller: _emailController,
      fieldText: "Email",
    );
  }

  Widget _passwordField() {
    return AppTextField(
      controller: _passwordController,
      validator: validatePassword,
      fieldText: "Password",
      obscureText: true,
    );
  }

  Widget _sumbmitButton() {
    return AppButton(
      onPressed: () async {
        var auth = await Authentication().createUser(
            email: _emailController.text, password: _passwordController.text);
        if (auth.success) {
          _emailController.text = "";
          _passwordController.text = "";
          FocusScope.of(context).requestFocus(_focusNode);
          Navigator.pushNamed(context, ChatScreen.routeName);
        } else {
          setState(() {
            _errorMessage = auth.errorMessage;
          });
        }
      },
      textButton: "Register",
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return ErrorMessage(
        errorMessage: _errorMessage,
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }
}
