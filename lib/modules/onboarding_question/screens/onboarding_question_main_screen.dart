import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/account_creation/main_account_creation.dart';
import 'package:finwise/modules/onboarding_question/widgets/account_creation/start_account_creation.dart';
import 'package:finwise/modules/onboarding_question/widgets/budgeting/main_budgeting.dart';
import 'package:finwise/modules/onboarding_question/widgets/budgeting/start_budgeting.dart';
import 'package:finwise/modules/onboarding_question/widgets/finance_snapshots/main_finance_snapshot.dart';
import 'package:finwise/modules/onboarding_question/widgets/finance_snapshots/start_finance_snapshot.dart';
import 'package:finwise/modules/onboarding_question/widgets/onboarding_header.dart';
import 'package:finwise/modules/onboarding_question/widgets/personal_questions/main_personal_question.dart';
import 'package:finwise/modules/onboarding_question/widgets/personal_questions/start_personal_questions.dart';
import 'package:finwise/modules/onboarding_question/widgets/smart_goal/main_smart_goal.dart';
import 'package:finwise/modules/onboarding_question/widgets/smart_goal/start_smart_goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class OnboardingQuestionMainScreen extends StatefulWidget {
  final VoidCallback startPage;

  const OnboardingQuestionMainScreen({
    super.key,
    required this.startPage,
  });

  @override
  State<OnboardingQuestionMainScreen> createState() =>
      _OnboardingQuestionMainScreenState();
}

class _OnboardingQuestionMainScreenState
    extends State<OnboardingQuestionMainScreen> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Container(
          height: fullHeight,
          child: Column(
            children: [
              Observer(builder: (context) {
                return OnboardingHeader(
                    previousPage: store.currentIndex == 1
                        ? widget.startPage
                        : store.previousPage);
              }),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 8),
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  child: AnimatedSwitcher(
                    duration: const Duration(microseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: _getCurrentWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCurrentWidget() {
    return Observer(builder: (context) {
      int currentIndex = store.currentIndex;

      switch (currentIndex) {
        case 1:
          return const StartPersonalQuestion();
        case 2:
          return const MainPersonalQuestion();
        case 3:
          return const StartFinanceSnapshot();
        case 4:
          return const MainFinanceSnapshot();
        case 5:
          return const StartBudgeting();
        case 6:
          return const MainBudgeting();
        case 7:
          return const StartSmartGoal();
        case 8:
          return const MainSmartGoal();
        case 9:
          return const StartAccountCreation();
        case 10:
          return const MainAccountCreation();
        default:
          return Container();
      }
    });
  }
}
