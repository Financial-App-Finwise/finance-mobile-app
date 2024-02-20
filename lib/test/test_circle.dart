import 'dart:math';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class CircularProgressIndicatorWithGradient extends StatefulWidget {
  @override
  _CircularProgressIndicatorWithGradientState createState() =>
      _CircularProgressIndicatorWithGradientState();
}

class _CircularProgressIndicatorWithGradientState
    extends State<CircularProgressIndicatorWithGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(100, 100),
        painter: MyPainter(_animation),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MyPainter extends CustomPainter {
  final Animation<double> animation;
  MyPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 10;
    double radius = size.width / 2 - strokeWidth;
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Drawing the first arc
    paint.shader = SweepGradient(
      colors: [Colors.blue, Colors.green],
      stops: [0.0, 1.0],
    ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius));
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: radius),
      pi / 4,
      2 * pi * animation.value,
      false,
      paint,
    );

    // Drawing the second arc
    paint.shader = SweepGradient(
      colors: [Colors.red, Colors.orange],
      stops: [0.0, 1.0],
    ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius));
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: radius),
      3 * pi / 4,
      -2 * pi * animation.value,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
