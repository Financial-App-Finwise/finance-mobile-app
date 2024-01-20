import 'package:finwise/core/widgets/calendar_header_layout.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_detail_screen.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_card.dart';
import 'package:finwise/modules/budget_plan/widgets/filter_bar.dart';
import 'package:flutter/material.dart';

class BudgetPlanScreen extends StatefulWidget {
  const BudgetPlanScreen({super.key});

  @override
  State<BudgetPlanScreen> createState() => _BudgetPlanScreenState();
}

class _BudgetPlanScreenState extends State<BudgetPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CalendarHeaderLayout(
        title: 'My budget plan',
        description: 'Effortlessly manage your finance with a powerful simple tool in FinWise',
        firstColor: const Color(0xFF0ABDE3),
        secondColor: const Color(0xFF0B8AAF),
        child: _mainContentListView(),
      ),
    );
  }

// Main content liste view
  Widget _mainContentListView() {
    return Container(
      color: const Color(0xFFF5F7F8),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 77,
        bottom: 16,
      ),
      child: Column(
        children: [
          _budgetOverview(3, 130, 30, 0, 150),
          const SizedBox(
            height: 16,
          ),
          const FilterBar(filterTitles: [
            'All',
            'One-time budget',
            'Monthly budget',
            'Monthly budget',
            'Monthly budget'
          ]),
          const SizedBox(
            height: 16,
          ),
          _budgetCard('Transportation', 7, 40, 10, 50),
          const SizedBox(
            height: 16,
          ),
          _budgetCard('Transportation', 7, 40, 10, 50),
          const SizedBox(
            height: 16,
          ),
          _budgetCard('Transportation', 7, 40, 10, 50),
        ],
      ),
    );
  }

  // Budget overview
  Widget _budgetOverview(
      int amount, int available, int spend, int overBudget, int plannedBudget) {
    return Column(
      children: [
        // Total budgets
        _totalBudget(amount),

        // Gap
        const SizedBox(
          height: 16,
        ),

        // Budget Overview Card
        _budgetOverviewCard(available, spend, overBudget, plannedBudget),
      ],
    );
  }

  // Total budget
  Widget _totalBudget(int amount) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(
          children: [
            // Icon
            const Icon(
              Icons.circle,
              size: 36,
              color: Color(0xFF0ABDE3),
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
                  '$amount',
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
    );
  }

  // Budget overview card
  Widget _budgetOverviewCard(
      int available, int spend, int overBudget, int plannedBudget) {
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
                  child: _budgetOverviewCardSection('Available', available,
                      const Color(0xFF10AC84), const Color(0xFF35D2A5)),
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
                  child: _budgetOverviewCardSection('Spend', spend,
                      const Color(0xFFEE5353), const Color(0xFFEE5353)),
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
                  child: _budgetOverviewCardSection('Over Budget', overBudget,
                      const Color(0xFFFE7B11), const Color(0xFFEF6007)),
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
                      'Planned Budget',
                      plannedBudget,
                      const Color(0xFF0ABDE3),
                      const Color(0xFF0B8AAF)),
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
      String category, int amount, Color iconColor, Color textColor) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: iconColor,
          size: 20,
        ),
        const SizedBox(
          width: 4,
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

  Widget _budgetCard(
      String title, int transaction, int remain, int spent, int total) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BudgetPlanDetailScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color(0xFFEE5353),
                      borderRadius: BorderRadius.circular(4)),
                  child: const Icon(
                    Icons.car_rental_outlined,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color(0xFFF2F2F2),
            ),
            const BudgetCard(transaction: 7, remain: 40, total: 50, spent: 10),
          ],
        ),
      ),
    );
  }
}
