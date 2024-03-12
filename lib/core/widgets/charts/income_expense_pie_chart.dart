import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:finwise/core/models/income_expense_model/income_expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class IncomeExpensePieChart extends StatefulWidget {
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
  State<IncomeExpensePieChart> createState() => _IncomeExpensePieChartState();
}

class _IncomeExpensePieChartState extends State<IncomeExpensePieChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPieChart(),
        const SizedBox(height: 30),
        _buildPieChartLegend(),
      ],
    );
  }

  // bool _showMorePieChartInfo = false;
  final List opacities = const [1.0, 0.75, 0.5, 0.25];

  Widget _buildPieChart() {
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
          sections: widget.data
              .map((e) => _buildPieChartItem(
                  value: e.amount, opacity: opacities[widget.data.indexOf(e)]))
              .toList(),
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
      color: widget.color.withOpacity(opacity),
      showTitle: false,
      radius: 25,
    );
  }

  Widget _buildPieChartLegend() {
    return Column(
      children: [
        Column(
            children: widget.data.map(
          (e) {
            int index = widget.data.indexOf(e);
            int nextIndex = index + 1;

            if (index % 2 == 0) {
              return Row(
                children: [
                  Expanded(
                      child: _buildPieChartLegendItem(
                          category: e.category,
                          amount: e.amount.toString(),
                          color: widget.color.withOpacity(opacities[index]))),
                  Expanded(
                      child: nextIndex < widget.data.length
                          ? _buildPieChartLegendItem(
                              category: widget.data[nextIndex].category,
                              amount: widget.data[nextIndex].amount.toString(),
                              color: widget.color
                                  .withOpacity(opacities[nextIndex]))
                          : const SizedBox()),
                ],
              );
            }
            return const SizedBox();
          },
        ).toList()),
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
