import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:flutter/material.dart';

abstract class FiancialTextStyle {
  static const totalBalanceTitle = GeneralTextStyle.s20w500;

  static const totalBalance = TextStyle(
    fontSize: 32,
    color: ColorConstant.primary,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );

  static const updateBalance = TextStyle(
    fontFamily: FontConstant.balooThambi2,
    fontSize: 16,
    color: ColorConstant.primary,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
  );

  static const updateBalanceTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );

}
  //styleName: Baloo Thambi/Subtitle/50;
// font-family: Baloo Thambi 2;
// font-size: 20px;
// font-weight: 500;
// line-height: 32px;
// letter-spacing: 1px;
// text-align: left;

// }
