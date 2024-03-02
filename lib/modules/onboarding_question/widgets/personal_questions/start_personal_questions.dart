import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/full_height_container.dart';
import 'package:flutter/material.dart';

class StartPersonalQuestion extends StatelessWidget {
  final VoidCallback nextPage;

  const StartPersonalQuestion({
    super.key,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return FullHeightContainer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconHelper.getSVG(
                    SVGName.pandaPersonalQuestion,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'We’d love to know about you better!',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      letterSpacing: 1,
                      color: ColorConstant.black,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Share a bit about yourself, and let's embark on a journey to tailor your financial adventure. Your unique story will guide us in creating a personalized roadmap to your financial goals. 🌌✨",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0.5,
                      color: ColorConstant.mainText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ContinueButton(nextPage: nextPage),
        ],
      ),
    );
  }
}
