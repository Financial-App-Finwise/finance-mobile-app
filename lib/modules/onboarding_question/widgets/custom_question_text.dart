import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class CustomQuestionText extends StatelessWidget {
  final String text;

  CustomQuestionText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: questionStyle,
    );
  }

  TextStyle questionStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    letterSpacing: 1,
    color: ColorConstant.black,
  );
}
