import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function? visiblePassword;
  final TextInputType? textInputType;
  final bool obscureText;

  const TextFieldCustom(
      {required this.labelText,
      required this.prefixIcon,
      required this.controller,
      required this.validator,
      this.textInputType,
      this.obscureText = false,
      this.suffixIcon,
      this.visiblePassword});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
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
