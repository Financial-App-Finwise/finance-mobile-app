import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/widgets/title_progress_card.dart';
import 'package:finwise/modules/budget_plan/models/budget_card.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_detail_screen.dart';
import 'package:finwise/core/widgets/filter_bar.dart';
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
        FilterBar(filterTitles: widget.filterTitles),
        const SizedBox(
          height: 16,
        ),
        for (int index = 0; index < widget.budgetCards.length; index++)
          Column(
            children: [
              TitleProgressCard(
                screen: const BudgetPlanDetailScreen(),
                title: widget.budgetCards[index].title,
                color: ColorConstant.expense,
                transaction: widget.budgetCards[index].transaction,
                remain: widget.budgetCards[index].remain,
                total: widget.budgetCards[index].total,
                spent: widget.budgetCards[index].spent,
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
}
