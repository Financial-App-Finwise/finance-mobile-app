import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:finwise/modules/finance/models/finance_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class IncomeExpenseBarChart extends StatelessWidget {
  const IncomeExpenseBarChart({
    super.key,
    required this.data,
  });

  final Map<String, IncomeExpenseCompare> data;

  @override
  Widget build(BuildContext context) {
    return _buildSpendingIncome();
  }

  Widget _buildSpendingIncome() {
    return Column(
      children: [
        // const Row(children: [
        //   Expanded(child: SizedBox()),
        //   DurationDropDown(),
        // ]),
        // const SizedBox(height: 24),
        _buildBarChart(),
        const SizedBox(height: 24),
        _buildBarChartLegend(),
      ],
    );
  }

  Widget _buildBarChart() {
    List<IncomeExpenseCompare> barGroups = [];
    if (data.isNotEmpty) {
      data.forEach((key, value) => barGroups.add(value));
    }
    // if (data.isNotEmpty) {
    //   data.forEach((key, value) => barGroups.add(value));
    // }
    return SizedBox(
      height: 200,
      child: BarChart(
        swapAnimationDuration: const Duration(milliseconds: 750),
        // swapAnimationDuration: Duration.zero,
        swapAnimationCurve: Curves.easeInOut,
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: ColorConstant.mainDark,
              // getTooltipItem: (group, groupIndex, rod, rodIndex) {
              //   return BarTooltipItem(
              //     '${rod.toY}',
              //     TextStyle(
              //       // backgroundColor: rodIndex % 2 == 0
              //       //     ? ColorConstant.income.withOpacity(0.4)
              //       //     : ColorConstant.expense.withOpacity(0.4),
              //       fontWeight: FontWeight.w600,
              //       color:  rodIndex % 2 == 0
              //           ? ColorConstant.income
              //           : ColorConstant.expense,
              //     ),
              //   );
              // },
            ),
          ),
          titlesData: FlTitlesData(
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 32,
                showTitles: true,
                getTitlesWidget: (value, meta) =>
                    _barChartBottomTitles(value, meta),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 48,
                showTitles: true,
                interval: 1000,
                getTitlesWidget: (value, meta) {
                  return _barChartleftTitles(value, meta);
                },
              ),
            ),
          ),
          gridData: FlGridData(
            getDrawingVerticalLine: (value) {
              return const FlLine(
                color: Color(0xfff2f2f2),
                dashArray: [4],
                strokeWidth: 1,
              );
            },
            getDrawingHorizontalLine: (value) {
              return const FlLine(
                color: Color(0xfff2f2f2),
                dashArray: [4],
                strokeWidth: 1,
              );
            },
            // verticalInterval: 0.25,
            verticalInterval:
                barGroups.isNotEmpty ? 1 / barGroups.length : 0.25,
            horizontalInterval: 1000,
          ),
          borderData: FlBorderData(
            border: const DashedBorder.fromBorderSide(
              side: BorderSide(color: Color(0xfff2f2f2)),
              dashLength: 4,
            ),
          ),
          alignment: BarChartAlignment.spaceAround,
          // barGroups: [
          //   _buildBarChartGroup(x: 0, income: 6000, expense: 4000),
          //   _buildBarChartGroup(x: 1, income: 4000, expense: 2000),
          //   _buildBarChartGroup(x: 2, income: 8000, expense: 6000),
          //   _buildBarChartGroup(x: 3, income: 7000, expense: 3000),
          // ],
          barGroups: barGroups
              .map(
                (e) => _buildBarChartGroup(
                  x: barGroups.indexOf(e),
                  income: double.parse(e.totalIncome.toString()),
                  expense: double.parse(e.totalExpense.toString()),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  BarChartGroupData _buildBarChartGroup({
    required int x,
    double income = 0,
    double expense = 0,
  }) {
    return BarChartGroupData(x: x, barRods: [
      _buildBarRod(isIncome: true, toY: income),
      _buildBarRod(toY: expense),
    ]);
  }

  BarChartRodData _buildBarRod({
    bool isIncome = false,
    double toY = 0,
  }) {
    return BarChartRodData(
      toY: toY,
      width: 7,
      color: isIncome ? ColorConstant.income : ColorConstant.expense,
      borderRadius: BorderRadius.zero,
    );
  }

  Widget _barChartBottomTitles(double value, TitleMeta meta) {
    // List titles = ['Sep 2023', 'Oct 2023', 'Nov 2023', 'Dec 2023'];

    List titles = [];
    data.forEach((key, value) {
      titles.add(key);
    });
    // if (data.isEmpty) {
    //   titles = ['Sep 2023', 'Oct 2023', 'Nov 2023', 'Dec 2023'];
    // } else {
    //   data.forEach((key, value) {
    //     titles.add(key);
    //   });
    // }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(titles[value.toInt()],
          style: HomeTextStyleConstant.barChartBottomTitle),
    );
  }

  Widget _barChartleftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('\$${value.toInt()}',
          style: HomeTextStyleConstant.barChartLeftTitle),
    );
  }

  Widget _buildBarChartLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _buildLegendItem('Income', ColorConstant.income)),
        Expanded(child: _buildLegendItem('Expense', ColorConstant.expense)),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: HomeTextStyleConstant.barChartLegend),
      ],
    );
  }
}
