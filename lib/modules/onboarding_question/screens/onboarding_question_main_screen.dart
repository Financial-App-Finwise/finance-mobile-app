import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/onboarding_question/models/radio_button_model.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/onboarding_header.dart';
import 'package:finwise/modules/onboarding_question/widgets/personal_questions/main_personal_question.dart';
import 'package:finwise/modules/onboarding_question/widgets/personal_questions/start_personal_questions.dart';
import 'package:flutter/material.dart';

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
  int _currentIndex = 1;
  int _personalQuestionIndex = 1;
  int _personalQuestionPage = 6;
  int _financialSnapShotIndex = 1;
  int _financialSnapShotPage = 6;

  void nextPage() {
    // Switch page for personal questions
    if (_currentIndex == 2) {
      if (_personalQuestionIndex >= _personalQuestionPage) {
        setState(() {
          _currentIndex += 1;
        });
      } else {
        setState(() {
          _personalQuestionIndex += 1;
        });
      }
    }

    // Switch page for financial snapshots
    if (_currentIndex == 3) {
      if (_financialSnapShotIndex >= _financialSnapShotPage) {
        setState(() {
          _currentIndex += 1;
        });
      } else {
        setState(() {
          _financialSnapShotIndex += 1;
        });
      }
    }

    if (_currentIndex == 1) {
      setState(() {
        _currentIndex += 1;
      });
    }
  }

  void previousPage() {
    if (_currentIndex <= 1) {
      widget.startPage();
    }

    // Switch page for personal questions
    if (_currentIndex == 2) {
      if (_personalQuestionIndex <= 1) {
        setState(() {
          _currentIndex -= 1;
        });
      } else {
        setState(() {
          _personalQuestionIndex -= 1;
        });
      }
    }

    // Switch page for financial snapshots
    if (_currentIndex == 3) {
      if (_financialSnapShotIndex <= 1) {
        setState(() {
          _currentIndex -= 1;
        });
      } else {
        setState(() {
          _financialSnapShotIndex -= 1;
        });
      }
    }
  }

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
              OnboardingHeader(previousPage: previousPage),
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

  RadioButtonModel _gender = RadioButtonModel();
  TextEditingController _age = TextEditingController();

  Widget _getCurrentWidget() {
    switch (_currentIndex) {
      case 1:
        return StartPersonalQuestion(
          nextPage: nextPage,
        );
      case 2:
        return MainPersonalQuestion(
          previousPage: previousPage,
          nextPage: nextPage,
          currentPage: _personalQuestionIndex,
          maxPage: _personalQuestionPage,
          selectedGender: _gender,
          selectGender: (gender) {
            setState(() {
              _gender = gender;
            });
          },
          ageController: _age,
        );
      default:
        return Container();
    }
  }
}
