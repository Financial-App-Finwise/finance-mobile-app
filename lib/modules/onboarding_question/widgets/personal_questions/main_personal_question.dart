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

  // Martial Status
  final void Function(RadioButtonModel) selectMartialStatus;
  final RadioButtonModel selectedMartialStatus;

  // Profession
  final void Function(RadioButtonModel) selectProfression;
  final RadioButtonModel selectedProfression;

  const MainPersonalQuestion({
    super.key,
    required this.previousPage,
    required this.nextPage,
    required this.currentPage,
    required this.maxPage,
    required this.selectGender,
    required this.selectedGender,
    required this.ageController,
    required this.selectMartialStatus,
    required this.selectedMartialStatus,
    required this.selectProfression,
    required this.selectedProfression,
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
        return _gender();
      case 2:
        return _age();
      case 3:
        return _martialStatus();
      case 4:
        return _profession();
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
          const TipText(
            title: 'We ask your age to create your personal plan',
            description:
                'Age is just a number, but it helps us understand your life stage better.',
          ),
        ],
      ),
    );
  }

  Widget _martialStatus() {
    return Column(
      children: [
        CustomRadioButton(
          setButton: widget.selectMartialStatus,
          question: 'What is your martial status',
          list: [
            RadioButtonModel('Married'),
            RadioButtonModel('Single'),
            RadioButtonModel('In relationship'),
            RadioButtonModel('I prefer not to say'),
          ],
          selectedButton: widget.selectedMartialStatus,
        ),
        const SizedBox(
          height: 20,
        ),
        const TipText(
          title: 'We ask your age to create your personal plan',
          description:
              "Whether it's a solo adventure or a duo dance, this detail helps us tailor the perfect chapters for your cosmic journey. 📖✨,",
        ),
      ],
    );
  }

  Widget _profession() {
    return Column(
      children: [
        CustomRadioButton(
          setButton: widget.selectProfression,
          question: 'Which stage do you resonate with the most?',
          list: [
            RadioButtonModel('Student'),
            RadioButtonModel('Young Professional'),
            RadioButtonModel('Mid career'),
            RadioButtonModel('Pre-retirement'),
            RadioButtonModel('Retired'),
            RadioButtonModel('I prefer not to say'),
          ],
          selectedButton: widget.selectedProfression,
        ),
        const SizedBox(
          height: 20,
        ),
        const TipText(
          title: 'We ask your age to create your personal plan',
          description:
              'Choose your stage, and let the cosmic adventure unfold! 🌌✨,',
        ),
      ],
    );
  }

  TextStyle questionStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    letterSpacing: 1,
    color: ColorConstant.black,
  );
}
