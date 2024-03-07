import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/modules/onboarding_question/models/spending_model.dart';
import 'package:finwise/modules/onboarding_question/models/radio_button_model.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_question_text.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_text_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/time_peroid_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/tip_text.dart';
import 'package:flutter/material.dart';

class MainFinanceSnapshot extends StatefulWidget {
  final VoidCallback previousPage;
  final VoidCallback nextPage;
  final int currentPage;
  final int maxPage;

  // Net worth
  final TextEditingController netWorth;

  // Monthly expense
  final SpendingModel expense;

  // Income
  final SpendingModel income;

  MainFinanceSnapshot({
    super.key,
    required this.previousPage,
    required this.nextPage,
    required this.currentPage,
    required this.maxPage,
    required this.netWorth,
    required this.expense,
    required this.income,
  });

  @override
  State<MainFinanceSnapshot> createState() => _MainFinanceSnapshotState();
}

class _MainFinanceSnapshotState extends State<MainFinanceSnapshot> {
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
                        value: widget.currentPage / widget.maxPage,
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
            ContinueButton(nextPage: widget.nextPage)
          ],
        ),
      ),
    );
  }

  Widget _getCurrentWidget() {
    switch (widget.currentPage) {
      case 1:
        return _netWorth();
      case 2:
        return _expense();
      case 3:
        return _income();
      default:
        return Container();
    }
  }

  Widget _netWorth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomQuestionText(text: 'What is your current net worth?'),
        const SizedBox(
          height: 32,
        ),
        CustomTextInput(
          label: 'Net worth',
          hintText: '\$ 2000',
          controller: widget.netWorth,
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
            setState(() {
              widget.expense.type = type;
            });
          },
          selectedType: widget.expense.type,
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextInput(
          label: widget.expense.type == 'Daily'
              ? 'Daily expense'
              : widget.expense.type == 'Weekly'
                  ? 'Weekly expense'
                  : 'Monthly expense',
          hintText: '\$ 2000',
          controller: widget.expense.controller,
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
            setState(() {
              widget.income.type = type;
            });
          },
          selectedType: widget.income.type,
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextInput(
          label: widget.income.type == 'Daily'
              ? 'Daily income'
              : widget.income.type == 'Weekly'
                  ? 'Weekly income'
                  : 'Monthly income',
          hintText: '\$ 2000',
          controller: widget.income.controller,
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
