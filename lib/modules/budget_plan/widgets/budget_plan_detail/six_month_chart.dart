import 'package:finwise/modules/budget_plan/widgets/bar_graph/bar_graph.dart';
import 'package:flutter/material.dart';

class SixMonthChart extends StatelessWidget {
  final List sixMonthBudget;

  const SixMonthChart({
    super.key,
    required this.sixMonthBudget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: BudgetBarGraph(
              sixMonthBudget: sixMonthBudget,
            ),
          ),
        ],
      ),
    );
  }
}
