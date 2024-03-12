import 'dart:async';

import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class LinearProgressDots extends StatefulWidget {
  const LinearProgressDots({super.key});

  @override
  State<LinearProgressDots> createState() => _LinearProgressDotsState();
}

class _LinearProgressDotsState extends State<LinearProgressDots> {
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
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _dotCount == index
                        ? ColorConstant.primary
                        : ColorConstant.colorA4A7C6,
                  ),
                  margin: const EdgeInsets.only(right: 5),
                ));
          }),
        ),
      ],
    );
  }
}
