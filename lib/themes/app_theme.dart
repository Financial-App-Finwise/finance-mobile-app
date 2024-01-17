import 'package:flutter/material.dart';
import 'package:test/core/constants/color_constant.dart';
import 'package:test/core/constants/font_constant.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: FontConstant.primary,
  primaryColor: ColorConstant.primary,
  textTheme: TextTheme(
    displayMedium: TextStyle(color: ColorConstant.bill),
  ),
);
