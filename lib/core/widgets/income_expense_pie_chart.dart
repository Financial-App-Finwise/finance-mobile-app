import 'package:finwise/core/constants/home_text_style_constant.dart';
import 'package:finwise/core/models/income_expense_model/income_expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class IncomeExpensePieChart extends StatelessWidget {
  const IncomeExpensePieChart({
    super.key,
    required this.data,
    this.customColors,
    this.color = Colors.blue,
  });

  final List<IncomeExpense> data;
  final List<Color>? customColors;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPieChart(data),
        const SizedBox(height: 30),
        _buildPieChartLegend(data),
      ],
    );
  }

  // bool _showMorePieChartInfo = false;
  Widget _buildPieChart(List<IncomeExpense> values) {
    return SizedBox.fromSize(
      size: const Size(140, 140),
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            // enabled: true,
            longPressDuration: const Duration(seconds: 3),
            touchCallback: (event, response) {
              // handle the long press on the same section
              // preventing it from printing the same value many times
              // setState(() {
              //   if (event.isInterestedForInteractions ||
              //       response == null ||
              //       response.touchedSection == null) {
              //     _touchedIndex = -1;
              //     return;
              //   }
              //   _touchedIndex = 0;
              //   debugPrint('${response.touchedSection!.touchedSectionIndex}');
              //   _showMorePieChartInfo = true;
              // });
            },
          ),
          sectionsSpace: 0,
          startDegreeOffset: 180,
          sections: [
            _buildPieChartItem(value: values[0].amount, opacity: 0.95),
            _buildPieChartItem(value: values[1].amount, opacity: 0.60),
            _buildPieChartItem(value: values[2].amount, opacity: 0.40),
            _buildPieChartItem(value: values[3].amount, opacity: 0.30),
          ],
        ),
        swapAnimationDuration: const Duration(seconds: 1),
      ),
    );
  }

  PieChartSectionData _buildPieChartItem({
    double value = 0.0,
    double opacity = 1.0,
  }) {
    return PieChartSectionData(
      value: value,
      // title: '$value',
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 10,
      ),
      color: color.withOpacity(opacity),
      showTitle: false,
      radius: 25,
    );
  }

  Widget _buildPieChartLegend(List<IncomeExpense> values) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildPieChartLegendItem(
                    category: values[0].category,
                    amount: '\$${values[0].amount}',
                    color: color.withOpacity(0.8),
                  ),
                ),
                Expanded(
                  child: _buildPieChartLegendItem(
                    category: values[1].category,
                    amount: '\$${values[1].amount}',
                    color: color.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildPieChartLegendItem(
                    category: values[2].category,
                    amount: '\$${values[2].amount}',
                    color: color.withOpacity(0.2),
                  ),
                ),
                Expanded(
                  child: _buildPieChartLegendItem(
                    category: values[3].category,
                    amount: '\$${values[3].amount}',
                    color: color.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChartLegendItem({
    String category = '',
    String amount = '',
    Color? color,
  }) {
    return Row(
      children: [
        _buildSmallCircle(color),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category, style: HomeTextStyleConstant.pieChartLegendSmall),
            Text(amount, style: HomeTextStyleConstant.pieChartLegendBig),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallCircle(Color? color) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Colors.black,
      ),
    );
  }
}
