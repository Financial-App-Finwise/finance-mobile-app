import 'package:flutter/material.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class CustomProgressBar extends StatefulWidget {
  final double value;
  final Color gradient1;
  final Color gradient2;

  const CustomProgressBar({
    Key? key,
    required this.value,
    required this.gradient1,
    required this.gradient2,
  }) : super(key: key);

  @override
  _CustomProgressBarState createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animation = Tween<double>(begin: widget.value, end: widget.value)
        .animate(_controller);
  }

  @override
  void didUpdateWidget(covariant CustomProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _animation.value) {
      _controller.reset();
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.value,
      ).animate(_controller)
        ..addListener(() {
          setState(() {});
        });
      _controller.animateTo(widget.value,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      value: _animation.value,
      backgroundColor: const Color(0xFFEDF2F7),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [widget.gradient1, widget.gradient2],
      ),
    );
  }
}
