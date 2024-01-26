import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';

class BudgetRecommendation extends StatelessWidget {
  final int amount;

  const BudgetRecommendation({
    super.key,
    required this.amount,
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
              '\$$amount suggested for Groceries based on spending over the last 6 months.',
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
