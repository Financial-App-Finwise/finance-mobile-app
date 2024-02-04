import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:flutter/material.dart';

// text styles to be used in specific section
class AuthScreenTextStyle {
  static const TextStyle topContentTitle = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    color: ColorConstant.black,
    fontSize: 32,
  );

  static const TextStyle topContentSubtitle = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    color: ColorConstant.mainText,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle formLabel = TextStyle(
    fontSize: 16,
    color: ColorConstant.mainText,
    fontFamily: FontConstant.primary,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle formText = TextStyle(
    fontWeight: FontWeight.w400,
    color: ColorConstant.mainText,
  );

  static const TextStyle formHint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstant.thin,
  );

  static const TextStyle button =  TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle medium = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    color: ColorConstant.mainText,
    fontSize: 14,
  );

  static const TextStyle regular = TextStyle(
    color: ColorConstant.mainText,
    fontSize: 14,
  );

  static const TextStyle boldLink = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 14,
    color: ColorConstant.boldLink,
  );

  static const TextStyle loadingTitle = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: ColorConstant.primary,
  );
}
