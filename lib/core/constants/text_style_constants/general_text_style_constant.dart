import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:flutter/material.dart';

abstract class GeneralTextStyle {
  @Deprecated('Use text style helper')
  static TextStyle getSize(double? size, {Color? color}) => TextStyle(
        fontFamily: FontConstant.balooThambi2Medium,
        fontSize: size ?? 14,
        fontWeight: FontWeight.w500,
        color: color ?? ColorConstant.mainText,
        letterSpacing: 1,
      );
      
  @Deprecated('Use text style helper')
  static TextStyle getHeader() => const TextStyle(
        fontSize: 20,
        letterSpacing: 1,
        fontWeight: FontWeight.w600,
        color: ColorConstant.mainText,
      );

  // --------- const values ------------

  // ---- fontweight = 400 ----
  static const s12w400 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ColorConstant.mainText,
    letterSpacing: 1,
  );

  // ---- fontweight = 500 ----
  static const s12w500 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ColorConstant.mainText,
    letterSpacing: 1,
  );

  static const s14w500 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ColorConstant.mainText,
    letterSpacing: 1,
  );

  static const s16w500 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorConstant.mainText,
    letterSpacing: 1,
  );

  static const s20w500 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: ColorConstant.mainText,
    letterSpacing: 1,
  );
}
