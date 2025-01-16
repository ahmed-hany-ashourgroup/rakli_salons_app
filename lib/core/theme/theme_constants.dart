import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff841919);
const kbackGroundColor = Color(0xff181E2E);
const kSecondaryColor = Color(0xffF0ECD7);
const kTextColor = Color(0xffA31D1D);
const kTextFieldBackgroundColor = Color(0xff181E2E);
const kBorderColor = Color(0xffE8BD81);

class AppTheme {
  final lightTheme = ThemeData(
    primaryColor: Color(0xffE8BD81),
    brightness: Brightness.light,
  );
  final darkTheme = ThemeData(
    primaryColor: Color(0xffE8BD81),
    brightness: Brightness.dark,
  );
}
