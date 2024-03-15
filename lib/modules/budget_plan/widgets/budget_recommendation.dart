import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';

class BudgetRecommendation extends StatelessWidget {
  final int amount;
  bool? nullData;

  BudgetRecommendation({
    super.key,
    required this.amount,
    this.nullData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Amount needed to be spent in this category.',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            letterSpacing: 0.5,
            height: 1.5,
            color: ColorConstant.mainText,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFFECFDFF),
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
                  nullData!
                      ? "You don't have data for the prediction yet."
                      : '\$$amount suggested for budget based on spending over the last 6 months.',
                  style: const TextStyle(
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
        ),
      ],
    );
  }
}
