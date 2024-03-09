import 'dart:math';
import 'package:flutter/material.dart';

class CircularProgressIndicatorTwoArcs extends StatefulWidget {
  const CircularProgressIndicatorTwoArcs({super.key});

  @override
  State<CircularProgressIndicatorTwoArcs> createState() =>
      _CircularProgressIndicatorTwoArcsState();
}

class _CircularProgressIndicatorTwoArcsState
    extends State<CircularProgressIndicatorTwoArcs>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: CircularProgressPainter(
            animationValue: _controller.value,
          ),
          size: Size.square(45.0),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CircularProgressPainter extends CustomPainter {
  final double animationValue;

  CircularProgressPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 10.0;
    final double radius = size.width / 2;
    final double arcRadius = radius - strokeWidth / 2;
    Offset center = Offset(0, 0); // Example center of the circle
    // double radius = 50; // Example radius of the circle
    Rect rect = Rect.fromCircle(center: center, radius: radius / 2);

    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        colors: [
          Color(0xff2197f1),
          Color(0xffd5f1fe),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    final paint2 = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        colors: [
          Color(0xffd5f1fe),
          Color(0xff2197f1),
        ], // Adjust colors as needed
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    canvas.save();
    canvas.translate(radius, radius);

    final double angle = 2 * pi * animationValue;

    // First Arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, 0), radius: arcRadius),
      angle + pi / 2,
      pi,
      false,
      paint,
    );

    // Second Arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, 0), radius: arcRadius),
      angle + pi / 2 + pi, // Start at 180 degrees
      pi,
      false,
      paint2,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return true;
  }
}
