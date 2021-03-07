import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final Widget suffixIcon;
  final TextEditingController controller;
  final Function(String) validator;
  final Function visiblePassword;
  final TextInputType textInputType;
  final bool obscureText;

  const TextFieldCustom(
      {Key key,
      this.labelText,
      this.prefixIcon,
      this.controller,
      this.validator,
      this.textInputType,
      this.obscureText = false,
      this.suffixIcon,
      this.visiblePassword})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator as String Function(String),
      obscureText: obscureText,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.white,
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
      ),
      keyboardType: textInputType,
    );
  }
}
