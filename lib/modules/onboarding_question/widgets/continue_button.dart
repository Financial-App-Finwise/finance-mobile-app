import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback nextPage;

  const ContinueButton({
    super.key,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: nextPage,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: ColorConstant.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 1,
            color: ColorConstant.white,
          ),
        ),
      ),
    );
  }
}
