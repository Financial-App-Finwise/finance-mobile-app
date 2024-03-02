import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/modules/onboarding_question/screens/onboarding_question_screen.dart';
import 'package:flutter/material.dart';

class BudgetOverview extends StatefulWidget {
  final int totalBudget;
  final int available;
  final int spend;
  final int overBudget;
  final int plannedBudget;

  const BudgetOverview({
    super.key,
    required this.totalBudget,
    required this.available,
    required this.spend,
    required this.overBudget,
    required this.plannedBudget,
  });

  @override
  State<BudgetOverview> createState() => _BudgetOverviewState();
}

class _BudgetOverviewState extends State<BudgetOverview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Total budgets
        _totalBudget(),

        // Gap
        const SizedBox(
          height: 16,
        ),

        // Budget Overview Card
        _budgetOverviewCard(),
      ],
    );
  }

  // Total budget
  Widget _totalBudget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingQuestionScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Row(
            children: [
              SizedBox(
                height: 36,
                width: 36,
                child: IconConstant.myBudget(
                  color: ColorConstant.secondary,
                ),
              ),

              const SizedBox(
                width: 12,
              ),
              // Text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total budgets',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333652),
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    '${widget.totalBudget}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0B8AAF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }

  // Budget overview card
  Widget _budgetOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _budgetOverviewCardSection(
                    IconConstant.available,
                    'Available',
                    widget.available,
                    const Color(0xFF35D2A5),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                const VerticalDivider(
                  color: Color(0xFFF2F2F2),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: _budgetOverviewCardSection(
                    IconConstant.spend,
                    'Spend',
                    widget.spend,
                    const Color(0xFFEE5353),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFFF2F2F2),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _budgetOverviewCardSection(
                    IconConstant.overBudget,
                    'Over Budget',
                    widget.overBudget,
                    const Color(0xFFEF6007),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                const VerticalDivider(
                  color: Color(0xFFF2F2F2),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: _budgetOverviewCardSection(
                    IconConstant.budgetPlan,
                    'Planned Budget',
                    widget.plannedBudget,
                    const Color(0xFF0B8AAF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Budget overview section
  Widget _budgetOverviewCardSection(
      Widget icon, String category, int amount, Color textColor) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333652),
              ),
            ),
            Text(
              '\$$amount',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
