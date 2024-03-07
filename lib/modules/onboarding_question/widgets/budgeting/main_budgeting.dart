import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/modules/onboarding_question/models/budgeting_model.dart';
import 'package:finwise/modules/onboarding_question/models/spending_model.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_drag_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_question_text.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_slider_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/time_peroid_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/tip_text.dart';
import 'package:flutter/material.dart';

class MainBudgeting extends StatefulWidget {
  final VoidCallback previousPage;
  final VoidCallback nextPage;
  final int currentPage;
  final int maxPage;

  // Financial Snapshot
  final SpendingModel income;

  // Budgeting
  final BudgetingModel budgeting;

  const MainBudgeting({
    super.key,
    required this.previousPage,
    required this.nextPage,
    required this.currentPage,
    required this.maxPage,
    required this.income,
    required this.budgeting,
  });

  @override
  State<MainBudgeting> createState() => _MainBudgetingState();
}

class _MainBudgetingState extends State<MainBudgeting> {
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
        return _idealBudget();
      default:
        return Container();
    }
  }

  Widget _idealBudget() {
    return Column(
      children: [
        CustomQuestionText(
            text: 'What’s your ideal budget for these categories?'),
        const SizedBox(
          height: 32,
        ),
        _goalOverviewCard(1000, 500),
        const SizedBox(
          height: 24,
        ),
        TimePeroidInput(
          changeType: (type) {
            setState(() {
              widget.budgeting.type = type;
            });
          },
          selectedType: widget.budgeting.type,
        ),
        const SizedBox(
          height: 24,
        ),
        const SizedBox(
          height: 24,
        ),
        _titleDragInput(
          'Housing',
          widget.budgeting.housing,
          (value) {
            setState(
              () {
                widget.budgeting.housing = value;
              },
            );
          },
        ),
        const SizedBox(
          height: 24,
        ),
        _titleDragInput(
          'Food',
          widget.budgeting.food,
          (value) {
            setState(
              () {
                widget.budgeting.food = value;
              },
            );
          },
        ),
        const SizedBox(
          height: 24,
        ),
        _titleDragInput(
          'Utilities',
          widget.budgeting.utilities,
          (value) {
            setState(
              () {
                widget.budgeting.utilities = value;
              },
            );
          },
        ),
        const SizedBox(
          height: 24,
        ),
        const TipText(
          title:
              "Congratulations! You've unlocked \$40 in monthly by sticking to your budget plan.",
          description:
              "Your disciplined budgeting is not just about numbers; it's about achieving your goals and celebrating your financial victories!",
          icon: '🎉',
        ),
      ],
    );
  }

  Widget _goalOverviewCard(int income, int incomeAfterBudget) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconHelper.getSVG(
                SVGName.earn,
                color: ColorConstant.mainText,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Monthly Income',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: 0.75,
                      color: ColorConstant.mainText,
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    '\$$income',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      letterSpacing: 1,
                      color: ColorConstant.mainText,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 17,
          ),
          Row(
            children: [
              IconHelper.getSVG(
                SVGName.earn,
                color: ColorConstant.secondary,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Monthly Income After Budget',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: 0.75,
                      color: ColorConstant.mainText,
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    '\$$incomeAfterBudget',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      letterSpacing: 1,
                      color: ColorConstant.primary,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _titleDragInput(
    String title,
    double value,
    void Function(double) onChange,
  ) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 28,
              width: 28,
              child: IconHelper.getSVG(SVGName.pandaFinancialSnapshot),
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 1,
                color: ColorConstant.black,
              ),
            )
          ],
        ),
        CustomSliderInput(
          inputValue: value,
          changeInput: onChange,
        ),
      ],
    );
  }
}
