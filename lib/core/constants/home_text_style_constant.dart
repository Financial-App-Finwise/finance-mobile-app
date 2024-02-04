import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:flutter/material.dart';

abstract class HomeTextStyleConstant {
  static const TextStyle welcome = TextStyle(
    color: ColorConstant.mainText,
    fontFamily: FontConstant.poppinsRegular,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle profileName = TextStyle(
    fontSize: 20,
    color: ColorConstant.mainText,
    fontFamily: FontConstant.poppinsRegular,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle header = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorConstant.black,
  );

  static const TextStyle headerBoldLink = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorConstant.primary,
  );

  static const TextStyle medium = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ColorConstant.mainText,
  );

  static const TextStyle small = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: ColorConstant.mainText,
  );

  static TextStyle numberFocus({Color color = Colors.black}) => TextStyle(
        fontFamily: FontConstant.balooThambi2Medium,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static const TextStyle barChartBottomTitle = TextStyle(
    fontFamily: FontConstant.interRegular,
    fontSize: 8,
    fontWeight: FontWeight.w400,
    color: Color(0xff4F4F4F),
  );

  static const TextStyle barChartLeftTitle = TextStyle(
    fontFamily: FontConstant.interRegular,
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: Color(0xff4F4F4F),
  );

  static const TextStyle barChartLegend = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle pieChartLegendSmall = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ColorConstant.mainText,
  );

  static const TextStyle pieChartLegendBig = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle budgetCardTitle = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle smallAddButton = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle transactionItemTitle = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ColorConstant.black,
  );

  static const TextStyle transactionItemSubtitle = TextStyle(
    fontFamily: FontConstant.balooThambi2Medium,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstant.thin,
  );

  static  TextStyle getTransactionItemSuffix({Color color = Colors.black}) =>
      TextStyle(
        fontFamily: FontConstant.balooThambi2Medium,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: color,
      );
}
