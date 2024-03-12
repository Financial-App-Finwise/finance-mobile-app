import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/modules/onboarding_question/models/radio_button_model.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_radio_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_number_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/tip_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainPersonalQuestion extends StatefulWidget {
  const MainPersonalQuestion({super.key});

  @override
  State<MainPersonalQuestion> createState() => _MainPersonalQuestionState();
}

class _MainPersonalQuestionState extends State<MainPersonalQuestion> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();

  List<bool> get isFormFilled => [
        store.gender.name != null ? true : false,
        store.age.text.isNotEmpty,
        store.martialStatus.name != null ? true : false,
        store.profression.name != null ? true : false,
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
                    child: CustomProgressBar(
                      value: store.personalQuestionIndex /
                          store.personalQuestionMaxPage,
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
            Observer(builder: (context) {
              return ContinueButton(
                nextPage: store.nextPage,
              isFormFilled: isFormFilled[store.personalQuestionIndex - 1],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _getCurrentWidget() {
    return Observer(builder: (context) {
      int personalQuestionIndex = store.personalQuestionIndex;

      switch (personalQuestionIndex) {
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
    });
  }

  Widget _gender() {
    return CustomRadioButton(
      selectedButton: store.gender,
      setButton: (gender) {
        store.gender = gender;
      },
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
          CustomNumberInput(
            label: 'Age',
            hintText: '20 year old',
            controller: store.age,
            onChange: (value) => setState(() {
              isFormFilled;
            }),
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
          selectedButton: store.martialStatus,
          setButton: (status) {
            store.martialStatus = status;
          },
          question: 'What is your martial status',
          list: [
            RadioButtonModel('Married'),
            RadioButtonModel('Single'),
            RadioButtonModel('In relationship'),
            RadioButtonModel('I prefer not to say'),
          ],
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
          selectedButton: store.profression,
          setButton: (profession) {
            store.profression = profession;
          },
          question: 'Which stage do you resonate with the most?',
          list: [
            RadioButtonModel('Student'),
            RadioButtonModel('Young Professional'),
            RadioButtonModel('Mid career'),
            RadioButtonModel('Pre-retirement'),
            RadioButtonModel('Retired'),
            RadioButtonModel('I prefer not to say'),
          ],
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
