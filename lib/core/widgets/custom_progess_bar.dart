import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double value;
  final Color color;

  const CustomProgressBar({
    super.key,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: LinearProgressIndicator(
        minHeight: 10,
        borderRadius: BorderRadius.circular(5),
        value: value,
        valueColor: AlwaysStoppedAnimation<Color>(
          color,
        ),
        backgroundColor: const Color(0xFFEDF2F7),
      ),
    );
  }
}
