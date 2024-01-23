import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';

class MainContent extends StatelessWidget {
  final VoidCallback? setIndex;

  const MainContent({
    super.key,
    this.setIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _mainContentDescription(),
        const SizedBox(
          height: 16,
        ),
        _mainContentButton(
          'One-time Budget',
          'Create a budget that applies to this month only',
        ),
        const SizedBox(
          height: 16,
        ),
        _mainContentButton(
          'Monthly Budget',
          'Create a budget that recurs every month',
        ),
      ],
    );
  }

  Widget _mainContentDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 72,
              height: 72,
              child: IconConstant.myBudget(
                color: ColorConstant.primary,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                'Setup and track your budget plan to avoid over budget and stress free.',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.75,
                  height: 1.5,
                  color: ColorConstant.mainText,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          'Choose type of budget plan',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.75,
            color: ColorConstant.mainText,
          ),
        ),
      ],
    );
  }

  Widget _mainContentButton(title, description) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorConstant.white,
          border: Border.all(
            width: 1,
            color: const Color(0xFFD3D5E4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  letterSpacing: 1,
                  color: ColorConstant.black),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.5,
                letterSpacing: 0.75,
                color: ColorConstant.lightBlack,
              ),
            )
          ],
        ),
      ),
    );
  }
}
