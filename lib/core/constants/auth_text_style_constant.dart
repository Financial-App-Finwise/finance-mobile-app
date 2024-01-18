import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:flutter/material.dart';

// text styles to be used in specific section
abstract class AuthScreenTextStyle {
  static TextStyle topContentTitle = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    color: ColorConstant.black,
    fontSize: 32,
  );

  static TextStyle topContentSubtitle = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    color: ColorConstant.mainText,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle formLabel = TextStyle(
    fontSize: 16,
    color: ColorConstant.mainText,
    fontFamily: FontConstant.primary,
    fontWeight: FontWeight.w400,
  );

  static TextStyle formText = TextStyle(
    fontWeight: FontWeight.w400,
    color: ColorConstant.mainText,
  );

  static TextStyle formHint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstant.thin,
  );

  static TextStyle button = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static TextStyle medium = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    color: ColorConstant.mainText,
    fontSize: 14,
  );

  static TextStyle regular = TextStyle(
    color: ColorConstant.mainText,
    fontSize: 14,
  );

  static TextStyle boldLink = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 14,
    color: ColorConstant.boldLink,
  );
}
