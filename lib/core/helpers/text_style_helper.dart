import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:flutter/material.dart';

abstract class TextStyleHelper {
  static TextStyle getw400size(double? size, {Color? color}) => TextStyle(
        fontSize: size ?? 14,
        fontWeight: FontWeight.w400,
        color: color ?? ColorConstant.mainText,
        letterSpacing: 1,
      );

  static TextStyle getw500size(double? size, {Color? color}) => TextStyle(
        fontSize: size ?? 14,
        fontWeight: FontWeight.w500,
        color: color ?? ColorConstant.mainText,
        letterSpacing: 1,
      );

  static TextStyle getw600size(double? size, {Color? color}) => TextStyle(
        fontSize: size ?? 14,
        fontWeight: FontWeight.w600,
        color: color ?? ColorConstant.mainText,
      );

  static TextStyle getw700size(double? size, {Color? color}) => TextStyle(
        fontSize: size ?? 14,
        fontWeight: FontWeight.w700,
        color: color ?? ColorConstant.mainText,
      );

  // ----- Home Screen -----
}
