import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:flutter/material.dart';

abstract class HomeTextStyleConstant {
  static TextStyle welcome = TextStyle(
    color: ColorConstant.mainText,
    fontFamily: FontConstant.poppinsRegular,
    fontWeight: FontWeight.w400,
  );

  static TextStyle profileName = TextStyle(
    fontSize: 20,
    color: ColorConstant.mainText,
    fontFamily: FontConstant.poppinsRegular,
    fontWeight: FontWeight.w500,
  );

  static TextStyle header = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorConstant.black,
  );

  static TextStyle headerBoldLink = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorConstant.primary,
  );

  static TextStyle medium = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ColorConstant.mainText,
  );

  static TextStyle small = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: ColorConstant.mainText,
  );

  static TextStyle numberFocus({Color color = Colors.black}) => TextStyle(
        fontFamily: FontConstant.balooThambi2Medium,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color,
      );
}
