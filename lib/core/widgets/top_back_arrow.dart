import 'package:flutter/material.dart';

class TopBackArrow extends StatelessWidget {
  const TopBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, size: 24),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          iconColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
        ),
      ),
    );
  }
}
