import 'package:flutter/material.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class GeneralProgressWidget extends StatelessWidget {
  const GeneralProgressWidget(
      {super.key,
      this.color = Colors.black,
      this.gradient,
      this.backgroundColor,
      this.total = 0,
      this.current = 0,
      this.topLeft,
      this.topRight,
      this.bottomLeft,
      this.bottomRight});

  final Color color;
  final LinearGradient? gradient;
  final Color? backgroundColor;
  final Widget? topLeft;
  final Widget? topRight;
  final Widget? bottomLeft;
  final Widget? bottomRight;
  final double total;
  final double current;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildProgress(),
    );
  }

  Widget _buildProgress() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              topLeft ?? const SizedBox(),
              topRight ?? const SizedBox(),
            ],
          ),
          const SizedBox(height: 6),
          Center(
            child: ProgressBar(
              width: double.infinity,
              value: current <= total ? (total <= 0 ? 0 : current / total) : 1,
              //specify only one: color or gradient
              //color:Colors.red,
              backgroundColor: backgroundColor ?? const Color(0xffEDF2F7),
              gradient: gradient ??
                  const LinearGradient(
                      colors: [Colors.blueAccent, Colors.greenAccent]),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomLeft ?? const SizedBox(),
              bottomRight ?? const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
