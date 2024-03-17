import 'package:flutter/material.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class CustomProgressBar extends StatelessWidget {
  final double value;
  final Color gradient1;
  final Color gradient2;
  const CustomProgressBar({
    super.key,
    required this.value,
    required this.gradient1,
    required this.gradient2,
  });

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      value: value,
      backgroundColor: const Color(0xFFEDF2F7),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [gradient1, gradient2],
      ),
    );
  }
}
