import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';

import '../theme/theme_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hint,
      this.obscureText = false,
      required this.controller,
      this.keyboardType,
      this.validator,
      this.hintColor = kTextColor,
      this.borderColor = kPrimaryColor,
      this.suffixIcon});
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Color hintColor, borderColor;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      controller: controller,
      style: AppStyles.regular24.copyWith(color: kbackGroundColor),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: AppStyles.regular24.copyWith(color: hintColor, fontSize: 22),
        enabledBorder: setBorder(color: borderColor),
        focusedBorder: setBorder(color: borderColor),
        border: setBorder(color: borderColor),
      ),
    );
  }
}

InputBorder? setBorder({Color color = kPrimaryColor}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: color, width: 2),
  );
}
