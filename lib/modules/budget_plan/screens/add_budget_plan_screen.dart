import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';

class AddBudgetPlanScreen extends StatefulWidget {
  const AddBudgetPlanScreen({super.key});

  @override
  State<AddBudgetPlanScreen> createState() => _AddBudgetPlanScreenState();
}

class _AddBudgetPlanScreenState extends State<AddBudgetPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _titleContent(),
              _mainContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleContent() {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        Text(
          'Add budget plan',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
      ],
    );
  }

  Widget _mainContent() {
    return Column(
      children: [
        _mainContentDescription(),
      ],
    );
  }

  Widget _mainContentDescription() {
    return Column(
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
            const Text(
              'Setup and track your budget plan to avoid over budget and stress free.',
              softWrap: true,
              style: TextStyle(),
            ),
          ],
        ),
      ],
    );
  }
}
