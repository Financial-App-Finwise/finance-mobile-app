import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/budget_plan/helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SixMonthChart extends StatelessWidget {
  final Map<String, dynamic> sixMonthBudget;
  final int average;
  final int thisMonth;

  SixMonthChart({
    super.key,
    required this.sixMonthBudget,
    required this.average,
    required this.thisMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last 6 Month',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: ColorConstant.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _barChart(),
              const SizedBox(
                height: 4,
              ),
              _budgetSummary(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _barChart() {
    return SizedBox(
      height: 171,
      child: BarChart(
        BarChartData(
          maxY: findMaxValue(sixMonthBudget).toDouble(),
          minY: 0,
          titlesData: const FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: bottomTitles,
              ),
            ),
          ),
          barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: EdgeInsets.zero,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toInt()}',
                TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: ColorConstant.expense,
                ),
              );
            },
          )),
          barGroups: _createBarGroups(),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    List<BarChartGroupData> barGroups = [];

    sixMonthBudget.forEach((month, value) {
      BarChartGroupData barGroup = BarChartGroupData(
        x: int.parse(month),
        barRods: [
          BarChartRodData(
            toY: value.toDouble(),
            gradient: const LinearGradient(
                colors: [Color(0xFFEE5353), Color(0xFFFBA6A6)],
                stops: [0.1, 0.9]),
            width: 41,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
        ],
        // showingTooltipIndicators: [0],
      );

      barGroups.add(barGroup);
    });

    return barGroups;
  }

  Widget _budgetSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Average',
              style: summaryTitle,
            ),
            Text(
              '\$$average',
              style: summaryAmount,
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This month',
              style: summaryTitle,
            ),
            Text(
              '\$$thisMonth',
              style: summaryAmount,
            ),
          ],
        ),
      ],
    );
  }

  TextStyle summaryTitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    letterSpacing: 1,
    color: ColorConstant.mainText,
  );

  TextStyle summaryAmount = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      letterSpacing: 1,
      color: Color(0xff000000));
}

Widget bottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Color(0xff52575C),
  );

  Widget text;
  switch (value) {
    case 1:
      text = const Text(
        'Jan',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'Feb',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'Mar',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'Apr',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'May',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'Jun',
        style: style,
      );
      break;
    case 7:
      text = const Text(
        'Jul',
        style: style,
      );
      break;
    case 8:
      text = const Text(
        'Aug',
        style: style,
      );
      break;
    case 9:
      text = const Text(
        'Sep',
        style: style,
      );
      break;
    case 10:
      text = const Text(
        'Oct',
        style: style,
      );
      break;
    case 11:
      text = const Text(
        'Nov',
        style: style,
      );
      break;
    default:
      text = const Text(
        'Dec',
        style: style,
      );
      break;
  }

  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
