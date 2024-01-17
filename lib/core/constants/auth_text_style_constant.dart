import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:flutter/material.dart';

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
    color: ColorConstant.mainText,
    fontWeight: FontWeight.w400,
  );

  static TextStyle formHint = TextStyle(
    color: ColorConstant.thin,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle button = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static TextStyle rememberMe = TextStyle(
    color: ColorConstant.mainText,
    fontSize: 14,
    fontFamily: FontConstant.balooThambi2Medium,
  );

  static TextStyle forgetPass = TextStyle(
    fontSize: 14,
    fontFamily: FontConstant.balooThambi2Medium,
    color: ColorConstant.boldLink,
  );

  static TextStyle noAccount = TextStyle();

  static TextStyle goToSignUp = TextStyle();

  static TextStyle boldLink = TextStyle();
}
