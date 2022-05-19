import 'package:flutter/material.dart';
import 'package:flutterscale/themes/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'NotoSansThai',
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.orange,
      accentColor: primaryColor
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: primaryTextColor)
    ),
    scaffoldBackgroundColor: primaryTextColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: primaryTextColor
    )
  );
}