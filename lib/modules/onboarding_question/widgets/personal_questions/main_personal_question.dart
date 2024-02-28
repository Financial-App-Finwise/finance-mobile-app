import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/modules/onboarding_question/models/radio_button_model.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_radio_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_text_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/tip_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPersonalQuestion extends StatefulWidget {
  final VoidCallback previousPage;
  final VoidCallback nextPage;
  final int currentPage;
  final int maxPage;

  // Gender
  final void Function(RadioButtonModel) selectGender;
  final RadioButtonModel selectedGender;

  // Age
  final TextEditingController ageController;

  const MainPersonalQuestion({
    super.key,
    required this.previousPage,
    required this.nextPage,
    required this.currentPage,
    required this.maxPage,
    required this.selectGender,
    required this.selectedGender,
    required this.ageController,
  });

  @override
  State<MainPersonalQuestion> createState() => _MainPersonalQuestionState();
}

class _MainPersonalQuestionState extends State<MainPersonalQuestion> {
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
                    AnimatedSwitcher(
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
                  ],
                ),
              ),
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
        return _gender();
      case 2:
        return _age();
      default:
        return Container();
    }
  }

  Widget _gender() {
    return CustomRadioButton(
      selectedButton: widget.selectedGender,
      setButton: widget.selectGender,
      list: [
        RadioButtonModel(
          'Female',
          IconHelper.getSVG(
            SVGName.addSquare,
          ),
        ),
        RadioButtonModel(
          'Male',
          IconHelper.getSVG(
            SVGName.addSquare,
          ),
        ),
        RadioButtonModel(
          'Non-binary',
          IconHelper.getSVG(
            SVGName.addSquare,
          ),
        ),
        RadioButtonModel(
          'I prefer not to say',
          IconHelper.getSVG(
            SVGName.addSquare,
          ),
        ),
      ],
      question: 'What is your gender?',
    );
  }

  Widget _age() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is your age?',
            style: questionStyle,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomTextInput(
            label: 'Age',
            controller: widget.ageController,
          ),
          const SizedBox(
            height: 24,
          ),
          TipText(
            title: 'We ask your age to create your personal plan',
            description:
                'Age is just a number, but it helps us understand your life stage better.',
          ),
        ],
      ),
    );
  }

  TextStyle questionStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    letterSpacing: 1,
    color: ColorConstant.black,
  );
}
