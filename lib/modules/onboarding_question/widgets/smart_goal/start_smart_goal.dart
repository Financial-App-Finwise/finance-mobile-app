import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartSmartGoal extends StatefulWidget {
  const StartSmartGoal({super.key});

  @override
  State<StartSmartGoal> createState() => _StartSmartGoalState();
}

class _StartSmartGoalState extends State<StartSmartGoal> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/smart_financial_goal.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text(
                        'Let’s Dream Big with Your SMART Financial Goals! 🌌💫',
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
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.5,
                            letterSpacing: 0.5,
                            color: ColorConstant.mainText,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text:
                                  "That's what SMART goals do! They make your goals: \n🎯 ",
                            ),
                            TextSpan(
                              text: "Specific",
                              style: boldLetter,
                            ),
                            const TextSpan(
                                text:
                                    ": Laser-focused and crystal clear.\n📏 "),
                            TextSpan(
                              text: 'Measurable',
                              style: boldLetter,
                            ),
                            const TextSpan(
                                text:
                                    ": Track progress like a cosmic explorer.\n🚀 "),
                            TextSpan(
                              text: 'Achievable',
                              style: boldLetter,
                            ),
                            const TextSpan(
                                text:
                                    ": Realistic and within your reach.\n🌐 "),
                            TextSpan(
                              text: 'Relevant',
                              style: boldLetter,
                            ),
                            const TextSpan(
                                text:
                                    ': Aligned with your unique situation.\n⏰ '),
                            TextSpan(
                              text: 'Time-bound',
                              style: boldLetter,
                            ),
                            const TextSpan(
                                text:
                                    ": Set deadlines for each celestial milestone."),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ContinueButton(nextPage: store.nextPage),
      ],
    );
  }

  TextStyle boldLetter = const TextStyle(fontWeight: FontWeight.w700);
}
