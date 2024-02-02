import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/home_text_style_constant.dart';
import 'package:finwise/core/widgets/duration_drop_down.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class IncomeExpenseBarChart extends StatefulWidget {
  const IncomeExpenseBarChart({super.key});

  @override
  State<IncomeExpenseBarChart> createState() => _IncomeExpenseBarChartState();
}

class _IncomeExpenseBarChartState extends State<IncomeExpenseBarChart> {
  @override
  Widget build(BuildContext context) {
    return _buildSpendingIncome();
  }

  Widget _buildSpendingIncome() {
    return Container(
      // color: Colors.green[100],
      alignment: Alignment.topLeft,
      child: _roundedContainer(
        child: Column(
          children: [
            Row(children: [
              Expanded(child: SizedBox()),
              DurationDropDown(),
            ]),
            SizedBox(height: 24),
            _buildBarChart(),
            SizedBox(height: 24),
            _buildBarChartLegend(),
          ],
        ),
      ),
    );
  }

  Widget _roundedContainer({Widget? child}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 200,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
              return FlLine(
                color: Color(0xfff2f2f2),
                dashArray: [4],
                strokeWidth: 1,
              );
            },
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Color(0xfff2f2f2),
                dashArray: [4],
                strokeWidth: 1,
              );
            },
            verticalInterval: 0.25,
            horizontalInterval: 1000,
          ),
          borderData: FlBorderData(
            border: DashedBorder.fromBorderSide(
              side: BorderSide(color: Color(0xfff2f2f2)),
              dashLength: 4,
            ),
          ),
          alignment: BarChartAlignment.spaceAround,
          barGroups: [
            _buildBarChartGroup(x: 0, income: 6000, expense: 4000),
            _buildBarChartGroup(x: 1, income: 4000, expense: 2000),
            _buildBarChartGroup(x: 2, income: 8000, expense: 6000),
            _buildBarChartGroup(x: 3, income: 7000, expense: 3000),
          ],
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
    final titles = ['Sep 2023', 'Oct 2023', 'Nov 2023', 'Dec 2023'];
    return SideTitleWidget(
      child: Text(titles[value.toInt()],
          style: HomeTextStyleConstant.barChartBottomTitle),
      axisSide: meta.axisSide,
    );
  }

  Widget _barChartleftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      child: Text('\$${value.toInt()}',
          style: HomeTextStyleConstant.barChartLeftTitle),
      axisSide: meta.axisSide,
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
        SizedBox(width: 8),
        Text(text, style: HomeTextStyleConstant.barChartLegend),
      ],
    );
  }

  Widget _buildDurationButton({
    VoidCallback? onPressed,
    String text = 'Button',
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xffD3D5E4)),
          ),
        ),
      ),
      child: Row(children: [
        Text(text, style: HomeTextStyleConstant.small),
        const Icon(Icons.arrow_drop_down, color: Color(0xff292D32)),
      ]),
    );
  }
}
