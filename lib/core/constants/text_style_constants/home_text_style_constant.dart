import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:flutter/material.dart';

abstract class HomeTextStyleConstant {
  // ---------- Profile ----------
  static const TextStyle welcome = TextStyle(
    color: ColorConstant.mainText,
    fontFamily: FontConstant.poppinsRegular,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle profileName = TextStyle(
    fontSize: 20,
    color: ColorConstant.mainText,
    fontFamily: FontConstant.poppinsMedium,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );

  // ---------- Header ----------
  static const TextStyle header = TextStyle(
    fontFamily: FontConstant.balooThambi2,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorConstant.black,
    letterSpacing: 1,
  );

  static const TextStyle headerBoldLink = TextStyle(
    fontFamily: FontConstant.balooThambi2,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorConstant.primary,
    letterSpacing: 1,
  );

  // ---------- General -----------
  static const TextStyle medium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ColorConstant.mainText,
    letterSpacing: 0.75,
  );

  static const TextStyle small = TextStyle(
    fontFamily: FontConstant.balooThambi2,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: ColorConstant.mainText,
    letterSpacing: 1,
  );

  @Deprecated('User helper')
  static TextStyle numberFocus({Color color = Colors.black}) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color,
      );

  @Deprecated('use the helper class instead')
  static TextStyle getTransactionItemSuffix({Color color = Colors.black}) =>
      TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 1,
      );

  // ---------- Bar Chart ----------
  static const TextStyle barChartBottomTitle = TextStyle(
    fontFamily: FontConstant.interRegular,
    fontSize: 8,
    fontWeight: FontWeight.w400,
    color: ColorConstant.color4F4F4F,
    letterSpacing: 1,
  );

  static const TextStyle barChartLeftTitle = TextStyle(
    fontFamily: FontConstant.interRegular,
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: ColorConstant.color4F4F4F,
    letterSpacing: 1,
  );

  static const TextStyle barChartLegend = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    letterSpacing: 1,
  );

  // --------- Pie Chart ----------
  static const TextStyle pieChartLegendSmall = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ColorConstant.mainText,
    letterSpacing: 1,
  );

  static const TextStyle pieChartLegendBig = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    letterSpacing: 1,
  );

  // ---------- Budget Plan ----------
  static const TextStyle budgetCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    letterSpacing: 1,
  );

  static const TextStyle smallAddButton = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 1,
  );

  // ---------- Transaction ----------
  static const TextStyle transactionItemTitle = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ColorConstant.black,
    letterSpacing: 0.75,
  );

  static const TextStyle transactionItemSubtitle = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstant.thin,
    letterSpacing: 0.25,
  );
}
