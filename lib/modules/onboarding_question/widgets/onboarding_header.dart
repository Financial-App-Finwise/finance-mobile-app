import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  final VoidCallback previousPage;

  const OnboardingHeader({
    super.key,
    required this.previousPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomIconButton(
          onPressed: previousPage,
          icon: IconHelper.getSVG(
            SVGName.arrowBack,
            color: const Color(0xFF292D32),
          ),
        ),
        // finwise text
        const Row(
          children: [
            Text(
              'fin',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 24,
                color: ColorConstant.secondary,
              ),
            ),
            Text(
              'wise',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 24,
                color: ColorConstant.mainText,
              ),
            ),
          ],
        ),
        const Text(
          'Skip',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: 0.75,
            color: ColorConstant.mainText,
          ),
        ),
      ],
    );
  }
}
