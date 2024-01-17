import 'package:flutter/material.dart';
import 'package:test/core/constants/color_constant.dart';
import 'package:test/core/constants/font_constant.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: FontConstant.primary,
  primaryColor: ColorConstant.primary,
  textTheme: TextTheme(
    headlineMedium: TextStyle(fontFamily: FontConstant.balooThambi2Medium, color: ColorConstant.black, fontSize: 32),
    bodyMedium: TextStyle(color: ColorConstant.mainText, fontSize: 14),
  ),
);
