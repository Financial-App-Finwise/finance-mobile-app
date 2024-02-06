import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:flutter/material.dart';

abstract class AuthScreenTextStyle {
  static const TextStyle topContentTitle = TextStyle(
    color: ColorConstant.black,
    fontSize: 32,
  );

  static const TextStyle topContentSubtitle = TextStyle(
    color: ColorConstant.mainText,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle formLabel = TextStyle(
    fontSize: 16,
    color: ColorConstant.mainText,
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
    fontFamily: FontConstant.balooThambi2,
  );

  static const TextStyle button =  TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle medium = TextStyle(
    color: ColorConstant.mainText,
    fontSize: 14,
  );

  static const TextStyle regular = TextStyle(
    color: ColorConstant.mainText,
    fontSize: 14,
  );

  static const TextStyle boldLink = TextStyle(
    fontSize: 14,
    color: ColorConstant.boldLink,
  );

  static const TextStyle loadingTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: ColorConstant.primary,
  );
}
