import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_number_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_question_text.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_text_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/money_option.dart';
import 'package:finwise/modules/onboarding_question/widgets/tip_text.dart';
import 'package:finwise/modules/smart_goal/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainSmartGoal extends StatefulWidget {
  const MainSmartGoal({super.key});

  @override
  State<MainSmartGoal> createState() => _MainSmartGoalState();
}

class _MainSmartGoalState extends State<MainSmartGoal> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();
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
      switch (store.smartGoalIndex) {
        case 1:
          return _financialGoal();
        case 2:
          return _saveForGoal();
        case 3:
          return _goalDate();
        default:
          return Container();
      }
    });
  }

  Widget _financialGoal() {
    return Column(
      children: [
        CustomQuestionText(text: 'What is your financial goal?'),
        const SizedBox(
          height: 32,
        ),
        CustomTextInput(
          label: 'Name your goal in 6 words',
          hintText: 'Eg. Travel around the world',
          controller: store.financialGoal,
          textLimit: 6,
        ),
        const SizedBox(
          height: 24,
        ),
        const TipText(
            icon: '🌟️',
            title: 'The Power of Six-Word Magic! ',
            description:
                "Naming a goal with the Six-Word Memoir rule is a strategy with powerful benefits: \n🔍 Encourages Clarity \n🎨 Promotes Simplicity \n💡 Inspires Creativity \n🌅 Promotes Reflection \n📚 Foundation for Narratives \n🚀 Shorthand for Impact"),
      ],
    );
  }

  Widget _saveForGoal() {
    return Column(
      children: [
        CustomQuestionText(
            text: 'How much are you aiming to save for this goal?'),
        const SizedBox(
          height: 32,
        ),
        CustomNumberInput(
          label: 'Dream Amount',
          hintText: '\$ 2000',
          controller: store.saveForGoal,
          isMoney: true,
        ),
        const SizedBox(
          height: 24,
        ),
        MoneyOption(
          setMoney: (value) {
            store.setSaveForGoalMoneyOption(value);
          },
        ),
        const SizedBox(
          height: 24,
        ),
        const TipText(
          icon: '🌟️',
          title:
              'We ask for your dream amount for personalized financial magic',
          description:
              "Your dream amount fuels our journey to create a financial roadmap filled with aspirations. \nLet's craft your financial destiny together! ✨💸\"",
        )
      ],
    );
  }

  Widget _goalDate() {
    return Column(
      children: [
        CustomQuestionText(text: 'When do you envision achieving your goal?'),
        const SizedBox(
          height: 32,
        ),
        _buildDate(
          label: 'Dream Deadline',
          hintText: '${UIHelper.getInputDate(store.goalDateDay.toString())}',
          controller: store.goalDate,
          onDaySelected: (selectedDay, focusedDay) {
            store.goalDate.text = UIHelper.getInputDate(
              selectedDay.toString(),
            );
            store.goalDateDay = selectedDay;
          },
        ),
        const SizedBox(
          height: 24,
        ),
        Observer(builder: (context) {
          return store.goalDate.text == ''
              ? const TipText(
                  icon: '💪',
                  title: 'You can achieve it by Nov 2026',
                  description:
                      'With your budgeting prowess, saving \$1,250/month paves the way to your goal, set to conquer by Nov 2026. ')
              : const TipText(
                  icon: '🚀',
                  title:
                      'Great! Your dream deadline sets our path to financial success.',
                  description:
                      "Let's work towards it together. Every day counts! ⏳ #DreamsIntoReality");
        })
      ],
    );
  }

  Widget _buildDate({
    String label = '',
    String hintText = '',
    TextEditingController? controller,
    required void Function(DateTime selectedDay, DateTime focusedDay)
        onDaySelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CalendarWidget(
                  onDaySelected: onDaySelected,
                ),
              ),
            );
          },
          style: TextStyleHelper.getw500size(14),
          readOnly: true,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: IconHelper.getSVG(
                SVGName.calendar,
                color: ColorConstant.mainText,
              ),
            ),
            hintText: hintText,
            hintStyle: GeneralTextStyle.getSize(12, color: ColorConstant.thin),
          ),
        ),
      ],
    );
  }
}
