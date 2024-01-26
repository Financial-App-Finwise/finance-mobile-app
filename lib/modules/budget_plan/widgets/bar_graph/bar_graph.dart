import 'package:finwise/modules/budget_plan/widgets/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BudgetBarGraph extends StatelessWidget {
  final List sixMonthBudget;

  const BudgetBarGraph({
    super.key,
    required this.sixMonthBudget,
  });

  @override
  Widget build(BuildContext context) {
    BarData sixMonthData = BarData(
      lastSixthMonth: sixMonthBudget[0],
      lastFifthMonth: sixMonthBudget[1],
      lastFourthMonth: sixMonthBudget[2],
      lastThirdMonth: sixMonthBudget[3],
      lastSecondMonth: sixMonthBudget[4],
      lastFirstMonth: sixMonthBudget[5],
    );

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        barGroups: sixMonthData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(toY: data.y),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
