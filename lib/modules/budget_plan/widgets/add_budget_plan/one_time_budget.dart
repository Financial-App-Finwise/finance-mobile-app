import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/modules/budget_plan/widgets/amount_input.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_recommendation.dart';
import 'package:finwise/modules/budget_plan/widgets/expenses_name_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OneTimeBudget extends StatefulWidget {
  final VoidCallback backToMain;

  const OneTimeBudget({
    super.key,
    required this.backToMain,
  });

  @override
  State<OneTimeBudget> createState() => _OneTimeBudgetState();
}

class _OneTimeBudgetState extends State<OneTimeBudget> {
  final _expenseNameController = TextEditingController();
  final _budgetAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _description(),
          const SizedBox(
            height: 12,
          ),
          _form(),
          const SizedBox(
            height: 20,
          ),
          _buttons(),
        ],
      ),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add one-time budget',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
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
                'Budget plan in specific category for this month only. ',
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
      ],
    );
  }

  Widget _form() {
    return Column(
      children: [
        // Amount input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AmountInput(controller: _budgetAmountController),
            const SizedBox(
              height: 8,
            ),
            Text(
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
            const BudgetRecommendation(amount: 74),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpenseNameInput(controller: _expenseNameController),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Category name will be used if no custom name is set.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: 0.5,
                height: 1.5,
                color: ColorConstant.mainText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => widget.backToMain(),
          child: _backButton(),
        ),
      ],
    );
  }

  Widget _backButton() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorConstant.primary,
          width: 1,
        ),
      ),
      child: Text(
        'Back',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 1,
          color: ColorConstant.primary,
        ),
      ),
    );
  }
}
