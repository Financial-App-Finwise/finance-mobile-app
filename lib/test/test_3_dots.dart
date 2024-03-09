import 'dart:async';

import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class LinearProgressWithDots extends StatefulWidget {
  @override
  _LinearProgressWithDotsState createState() => _LinearProgressWithDotsState();
}

class _LinearProgressWithDotsState extends State<LinearProgressWithDots> {
  int _dotCount = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _dotCount == index
                  ? Text('. ',
                      style:
                          TextStyle(fontSize: 24, color: ColorConstant.primary))
                  : Text('. ',
                      style: TextStyle(
                          fontSize: 24, color: ColorConstant.colorA4A7C6)),
            );
          }),
        ),
      ],
    );
  }
}
