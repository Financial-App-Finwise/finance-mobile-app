import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/modules/onboarding_question/models/budgeting_model.dart';
import 'package:finwise/modules/onboarding_question/models/spending_model.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_drag_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_question_text.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_slider_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/time_peroid_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/tip_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainBudgeting extends StatefulWidget {
  const MainBudgeting({super.key});

  @override
  State<MainBudgeting> createState() => _MainBudgetingState();
}

class _MainBudgetingState extends State<MainBudgeting> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();

  List<bool> get isFormFilled => [
        store.housing > 0 && store.food > 0 && store.utilities > 0,
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Observer(builder: (context) {
                        return CustomProgressBar(
                          value: store.budgetingIndex / store.budgetingMaxPage,
                          gradient1: ColorConstant.secondary,
                          gradient2: ColorConstant.primary,
                        );
                      })),
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
            const SizedBox(
              height: 20,
            ),
            ContinueButton(
              nextPage: store.nextPage,
              isFormFilled: isFormFilled[store.budgetingIndex - 1],
            )
          ],
        ),
      ),
    );
  }

  Widget _getCurrentWidget() {
    return Observer(builder: (context) {
      int budgetingIndex = store.budgetingIndex;

      switch (budgetingIndex) {
        case 1:
          return _idealBudget();
        default:
          return Container();
      }
    });
  }

  Widget _idealBudget() {
    return Column(
      children: [
        CustomQuestionText(
            text: 'What’s your ideal budget for these categories?'),
        const SizedBox(
          height: 32,
        ),
        Observer(builder: (context) {
          double incomeAfterBudget = store.incomeAfterBudget;
          double incomeAmount = store.incomeAmount;

          return _goalOverviewCard(
            incomeAmount.toInt(),
            incomeAfterBudget.toInt(),
          );
        }),
        const SizedBox(
          height: 24,
        ),
        TimePeroidInput(
          changeType: (type) {
            store.budgetingType = type;
          },
          selectedType: store.budgetingType,
        ),
        const SizedBox(
          height: 24,
        ),
        const SizedBox(
          height: 24,
        ),
        _titleDragInput(
          'Housing',
          store.housing,
          (value) {
            setState(
              () {
                store.housing = value;
              },
            );
          },
        ),
        const SizedBox(
          height: 24,
        ),
        _titleDragInput(
          'Food',
          store.food,
          (value) {
            setState(
              () {
                store.food = value;
              },
            );
          },
        ),
        const SizedBox(
          height: 24,
        ),
        _titleDragInput(
          'Utilities',
          store.utilities,
          (value) {
            setState(
              () {
                store.utilities = value;
              },
            );
          },
        ),
        const SizedBox(
          height: 24,
        ),
        Observer(builder: (context) {
          return store.incomeAfterBudget >= 0
              ? TipText(
                  title:
                      "Congratulations! You've unlocked \$${store.incomeAfterBudget.toInt()} in monthly by sticking to your budget plan.",
                  description:
                      "Your disciplined budgeting is not just about numbers; it's about achieving your goals and celebrating your financial victories!",
                  icon: '🎉',
                )
              : const TipText(
                  title:
                      "Adjust and Conquer! It seems you've exceeded your budget this month.",
                  description:
                      "No worries! Learn from this experience, make adjustments, and stay committed to your financial goals. Every setback is an opportunity for a comeback! 🔄💡",
                  icon: '🚨️',
                );
        }),
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
                  ),
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
              child: IconHelper.getSVGDefault(SVGName.pandaFinancialSnapshot),
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
