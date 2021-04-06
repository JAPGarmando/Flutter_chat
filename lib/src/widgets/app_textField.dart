import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String fieldText;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldValidator<String> validator;
  const AppTextField(
      {Key key,
      this.fieldText = "Email",
      this.obscureText = false,
      this.onChanged,
      this.controller,
      this.focusNode,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2)),
          hintText: fieldText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.blueAccent, width: 2))),
    );
  }
}
