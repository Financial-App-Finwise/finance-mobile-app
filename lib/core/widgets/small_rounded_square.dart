import 'package:flutter/material.dart';

class SmallRoundedSquare extends StatelessWidget {
  const SmallRoundedSquare({
    super.key,
    this.color = Colors.black,
    this.icon
  });

  final Color color;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: icon,
    );
  }
}
