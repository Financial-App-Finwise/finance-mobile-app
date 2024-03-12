import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:finwise/modules/auth/screens/sign_up_screen.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/full_height_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartAccountCreation extends StatefulWidget {
  const StartAccountCreation({super.key});

  @override
  State<StartAccountCreation> createState() => _StartAccountCreationState();
}

class _StartAccountCreationState extends State<StartAccountCreation> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();
  @override
  Widget build(BuildContext context) {
    return FullHeightContainer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconHelper.getSVGDefault(
                  SVGName.pandaExcited,
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  '🎉 Congratulations on completing your onboarding! 🎉',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    height: 1.5,
                    letterSpacing: 1,
                    color: ColorConstant.black,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Your dedication to this process is the first step towards achieving your financial dreams. We're here to support and guide you every step of the way. Let's embark on this exciting journey together!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.5,
                    letterSpacing: 0.5,
                    color: ColorConstant.mainText,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ContinueButton(nextPage: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          }),
        ],
      ),
    );
  }
}
