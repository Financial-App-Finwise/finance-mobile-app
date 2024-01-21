import 'package:finwise/modules/budget_plan/models/budget_card.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_detail_screen.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_card.dart';
import 'package:finwise/modules/budget_plan/widgets/filter_bar.dart';
import 'package:flutter/material.dart';

class FilteredBudget extends StatefulWidget {
  final List<String> filterTitles;
  final List<BudgetCardModel> budgetCards;

  const FilteredBudget({
    super.key,
    required this.filterTitles,
    required this.budgetCards,
  });

  @override
  State<FilteredBudget> createState() => _FilteredBudgetState();
}

class _FilteredBudgetState extends State<FilteredBudget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterBar(
          filterTitles: widget.filterTitles
        ),
        const SizedBox(
          height: 16,
        ),
        for (int index = 0; index < widget.budgetCards.length; index++)
          Column(
            children: [
              _budgetCard(
                widget.budgetCards[index].title,
                widget.budgetCards[index].transaction,
                widget.budgetCards[index].remain,
                widget.budgetCards[index].spent,
                widget.budgetCards[index].total,
              ),
              if (index < widget.budgetCards.length - 1)
                const SizedBox(
                  height: 16,
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
            BudgetCard(
                transaction: transaction,
                remain: remain,
                total: total,
                spent: spent),
          ],
        ),
      ),
    );
  }
}
