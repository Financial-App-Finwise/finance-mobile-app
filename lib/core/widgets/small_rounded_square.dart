import 'package:flutter/material.dart';

class SmallRoundedSquare extends StatefulWidget {
  SmallRoundedSquare({
    super.key,
    this.color = Colors.black,
    this.icon
  });

  late Color color;
  late Widget? icon;

  @override
  State<SmallRoundedSquare> createState() => _SmallRoundedSquareState();
}

class _SmallRoundedSquareState extends State<SmallRoundedSquare> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: widget.icon,
    );
  }
}
