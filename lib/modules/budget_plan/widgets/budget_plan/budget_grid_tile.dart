import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class BudgetGridTile extends StatelessWidget {
  final String month;
  final int budget;

  const BudgetGridTile({
    super.key,
    required this.month,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    String budgetString = budget > 1 ? 'budgets' : 'budget';

    return Container(
      width: 103.67,
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            month,
            style: TextStyle(
              letterSpacing: 0.75,
              color: ColorConstant.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '$budget $budgetString',
            style: TextStyle(
              letterSpacing: 0.75,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorConstant.grayScale,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                size: 16,
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                iconColor: MaterialStateProperty.all(
                  ColorConstant.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
