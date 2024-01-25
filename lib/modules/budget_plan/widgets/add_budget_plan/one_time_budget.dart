import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
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
    return Column(
      children: [
        _description(),
      ],
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
        const SizedBox(
          height: 12,
        ),
        _form(),
        const SizedBox(
          height: 20,
        ),
        _buttons(),
      ],
    );
  }

  Widget _form() {
    return Column(
      children: [
        // Budget amount
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _budgetAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.75,
                color: ColorConstant.mainText,
              ),
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  label: Text(
                    'Amount',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      letterSpacing: 0.75,
                      color: ColorConstant.mainText,
                    ),
                  ),
                  prefixText: '\$',
                  prefixStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 0.75,
                    color: ColorConstant.mainText,
                  ),
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.75,
                    color: ColorConstant.thin,
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  filled: true,
                  fillColor: ColorConstant.white),
            ),
            const SizedBox(
              height: 12,
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
            )
          ],
        ),

        const SizedBox(
          height: 20,
        ),

        // Expense name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _expenseNameController,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.75,
                color: ColorConstant.mainText,
              ),
              decoration: InputDecoration(
                  hintText: "Expense name (Optional)",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.75,
                    color: ColorConstant.thin,
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  filled: true,
                  fillColor: ColorConstant.white),
            ),
            const SizedBox(
              height: 12,
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
            )
          ],
        )
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
