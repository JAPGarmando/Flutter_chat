import 'package:flutter/material.dart';
import 'package:flutter_chat/src/mixins/validation_mixins.dart';
import 'package:flutter_chat/src/screens/chat_screen.dart';
import 'package:flutter_chat/src/services/authentication.dart';
import 'package:flutter_chat/src/widgets/app_button.dart';
import 'package:flutter_chat/src/widgets/app_error_message.dart';
import 'package:flutter_chat/src/widgets/app_icon.dart';
import 'package:flutter_chat/src/widgets/app_textField.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixins {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _focusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool inAsyncCall = false;
  String _errorMessage = "";
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void setInAsyncCall(bool active) {
    setState(() {
      inAsyncCall = active;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppIcon(),
                SizedBox(
                  height: 45,
                ),
                _emailField(),
                SizedBox(
                  height: 10,
                ),
                _passwordField(),
                SizedBox(
                  height: 30,
                ),
                _showErrorMessage(),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return AppTextField(
      validator: validateEmail,
      focusNode: _focusNode,
      controller: _emailController,
      fieldText: "Email",
    );
  }

  Widget _passwordField() {
    return AppTextField(
      validator: validatePassword,
      controller: _passwordController,
      fieldText: "Password",
      obscureText: true,
    );
  }

  Widget _submitButton() {
    return AppButton(
      onPressed: () async {
        _formKey.currentState.validate();
        if (!_formKey.currentState.validate()) return;
        setInAsyncCall(true);
        var auth = await Authentication().logInUser(
            email: _emailController.text, password: _passwordController.text);
        if (auth.success) {
          Navigator.pushNamed(context, ChatScreen.routeName);
          FocusScope.of(context).requestFocus(_focusNode);
          _emailController.text = "";
          _passwordController.text = "";
        } else {
          setState(() {
            _errorMessage = auth.errorMessage;
          });
          print(auth.errorMessage);
        }
        setInAsyncCall(false);
      },
      textButton: "Log In",
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
