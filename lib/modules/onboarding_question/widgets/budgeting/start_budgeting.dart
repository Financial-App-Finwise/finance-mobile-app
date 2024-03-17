import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/full_height_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartBudgeting extends StatefulWidget {
  const StartBudgeting({
    super.key,
  });

  @override
  State<StartBudgeting> createState() => _StartBudgetingState();
}

class _StartBudgetingState extends State<StartBudgeting> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();

  @override
  Widget build(BuildContext context) {
    return FullHeightContainer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconHelper.getSVGDefault(
                            SVGName.pandaFinancialSnapshot,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Text(
                            'Budgeting offers a range of benefits that contribute to your financial well-being.',
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
                            "💡 Helps You Work Towards Long-Term Goals \n🚀 Gives You Control of Your Finances \n💳 Ensures You Only Spend What You Can Afford \n💰 Helps You Save Money \n😌 Reduces Stress",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 0.5,
                              color: ColorConstant.mainText,
                            ),
                          ),
                        ]),
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
      ),
    );
  }
}
