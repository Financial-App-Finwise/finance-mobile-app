import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartFinanceSnapshot extends StatefulWidget {
  const StartFinanceSnapshot({
    super.key,
  });

  @override
  State<StartFinanceSnapshot> createState() => _StartFinanceSnapshotState();
}

class _StartFinanceSnapshotState extends State<StartFinanceSnapshot> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
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
                "Now that we've had a glimpse of who you are, let's dive into the exciting world of your financial snapshot.",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  height: 1.5,
                  letterSpacing: 1,
                  color: ColorConstant.black,
                ),
              ),
            ],
          ),
        ),
        ContinueButton(nextPage: store.nextPage),
      ],
    );
  }
}
