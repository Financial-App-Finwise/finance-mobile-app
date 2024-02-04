import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/constants/general_text_style_constant.dart';
import 'package:flutter/material.dart';

class SmartGoalTextStyle {
  static TextStyle totalNumber =
      GeneralTextStyle.getSize(32, color: const Color(0xff35D2A5));

  static TextStyle totalTitle = GeneralTextStyle.getSize(20);

  static TextStyle statusAmount =
      GeneralTextStyle.getSize(24, color: ColorConstant.black)
          .copyWith(fontWeight: FontWeight.w600);

  static TextStyle getCardTitle({Color color = Colors.black}) => TextStyle(
        fontFamily: FontConstant.balooThambi2Medium,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle cardSubTitle = GeneralTextStyle.getSize(14);
}
