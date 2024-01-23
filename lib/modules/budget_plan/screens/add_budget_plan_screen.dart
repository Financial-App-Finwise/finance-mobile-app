import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/modules/budget_plan/widgets/add_budget_plan/main_content.dart';
import 'package:finwise/modules/budget_plan/widgets/add_budget_plan/monthly_budget.dart';
import 'package:finwise/modules/budget_plan/widgets/add_budget_plan/one_time_budget.dart';
import 'package:flutter/material.dart';

class AddBudgetPlanScreen extends StatefulWidget {
  const AddBudgetPlanScreen({super.key});

  @override
  State<AddBudgetPlanScreen> createState() => _AddBudgetPlanScreenState();
}

class _AddBudgetPlanScreenState extends State<AddBudgetPlanScreen> {
  int _currentWidgetIndex = 0;

  List<Widget> widgets = const [
    MainContent(),
    OneTimeBudget(),
    MonthlyBudget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleContent(),
              const SizedBox(
                height: 32,
              ),
              AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: _currentWidgetIndex == 0
                    ? MainContent(
                        setIndex: () => setState(() {
                          _currentWidgetIndex = 1;
                        }),
                      )
                    : widgets[_currentWidgetIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: IconConstant.close,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: CustomProgressBar(
                  value: 0.5,
                  color: ColorConstant.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
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
