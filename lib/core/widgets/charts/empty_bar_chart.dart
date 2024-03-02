import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EmptyBarChart extends StatelessWidget {
  const EmptyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          barTouchData: BarTouchData(enabled: false),
          barGroups: [
          BarChartGroupData(
            x: 0,
            barsSpace: 12,
            barRods: [
              BarChartRodData(
                toY: 40,
                width: 35,
                color: const Color(0xffA4A7C6),
                borderRadius: BorderRadius.circular(8),
              ),
              BarChartRodData(
                toY: 100,
                width: 35,
                color: const Color(0xffD3D5E4),
                borderRadius: BorderRadius.circular(8),
              ),
              BarChartRodData(
                toY: 60,
                width: 35,
                color: const Color(0xffA4A7C6),
                borderRadius: BorderRadius.circular(8),
              )
            ],
          )
        ]),
      ),
    );
  }
}
