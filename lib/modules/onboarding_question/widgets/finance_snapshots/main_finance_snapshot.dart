import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/modules/onboarding_question/models/spending_model.dart';
import 'package:finwise/modules/onboarding_question/models/radio_button_model.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_question_text.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_number_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/time_peroid_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/tip_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainFinanceSnapshot extends StatefulWidget {
  const MainFinanceSnapshot({super.key});

  @override
  State<MainFinanceSnapshot> createState() => _MainFinanceSnapshotState();
}

class _MainFinanceSnapshotState extends State<MainFinanceSnapshot> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CustomProgressBar(
                        value: store.financialSnapshotIndex /
                            store.financialSnapshotMaxPage,
                        gradient1: ColorConstant.secondary,
                        gradient2: ColorConstant.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: AnimatedSwitcher(
                          duration: const Duration(microseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: _getCurrentWidget(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ContinueButton(nextPage: store.nextPage)
          ],
        ),
      ),
    );
  }

  Widget _getCurrentWidget() {
    return Observer(builder: (context) {
      int financialSnapshotIndex = store.financialSnapshotIndex;

      switch (financialSnapshotIndex) {
        case 1:
          return _netWorth();
        case 2:
          return _expense();
        case 3:
          return _income();
        default:
          return Container();
      }
    });
  }

  Widget _netWorth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomQuestionText(text: 'What is your current net worth?'),
        const SizedBox(
          height: 32,
        ),
        CustomNumberInput(
          label: 'Net worth',
          hintText: '\$ 2000',
          controller: store.networth,
          isMoney: true,
        ),
        const SizedBox(
          height: 24,
        ),
        const TipText(
          title: 'We ask your net worth to create your personal plan',
          description:
              'Entering this number launches us into a cosmic exploration, shaping a personalized financial adventure just for you.',
        )
      ],
    );
  }

  Widget _expense() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomQuestionText(
            text: 'How much do you find yourself spending money?'),
        const SizedBox(
          height: 32,
        ),
        TimePeroidInput(
          changeType: (type) {
            store.expense = type;
          },
          selectedType: store.expense,
        ),
        const SizedBox(
          height: 24,
        ),
        CustomNumberInput(
          label: store.expense.type == 'Daily'
              ? 'Daily expense'
              : store.expense.type == 'Weekly'
                  ? 'Weekly expense'
                  : 'Monthly expense',
          hintText: '\$ 2000',
          controller: store.expense.controller,
          isMoney: true,
        ),
        const SizedBox(
          height: 24,
        ),
        const TipText(
          title:
              'Understanding your expenses helps us craft personalized insights',
          description:
              'Your input fuels a customized journey to financial success.',
        )
      ],
    );
  }

  Widget _income() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomQuestionText(text: 'How much is your income?'),
        const SizedBox(
          height: 32,
        ),
        TimePeroidInput(
          changeType: (type) {
            store.income = type;
          },
          selectedType: store.income,
        ),
        const SizedBox(
          height: 24,
        ),
        CustomNumberInput(
          label: store.income.type == 'Daily'
              ? 'Daily income'
              : store.income.type == 'Weekly'
                  ? 'Weekly income'
                  : 'Monthly income',
          hintText: '\$ 2000',
          controller: store.income.controller,
          isMoney: true,
        ),
        const SizedBox(
          height: 24,
        ),
        const TipText(
          title: 'Reveal your income to ignite a tailored financial roadmap! ',
          description:
              'Knowing your earnings allows us to craft personalized strategies, maximizing your financial potential.',
        )
      ],
    );
  }
}
