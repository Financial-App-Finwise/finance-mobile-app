import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';

class SmartGoalPrediction extends StatelessWidget {
  // final int amount;

  const SmartGoalPrediction({
    super.key,
    // required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDFF),
        border: Border(
          left: BorderSide(
            color: ColorConstant.primary,
            width: 4,
          ),
        ),
      ),
      child: Row(
        children: [
          IconConstant.infoALert,
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              'You will achieve this goal by May 2023.',
              style: TextStyle(
                fontFamily: FontConstant.poppinsRegular,
                fontWeight: FontWeight.w300,
                fontSize: 12,
                height: 1.5,
                letterSpacing: 0.5,
                color: ColorConstant.mainDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
