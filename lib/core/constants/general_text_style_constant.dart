import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:flutter/material.dart';

class GeneralTextStyle {
  static TextStyle getSize(double? size, {Color? color}) => TextStyle(
        fontFamily: FontConstant.balooThambi2Medium,
        fontSize: size ?? 14,
        fontWeight: FontWeight.w500,
        color: color ?? ColorConstant.mainText,
      );

  static TextStyle getHeader() => TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorConstant.black,
  );
}
